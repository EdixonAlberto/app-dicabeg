<?php

namespace V2\Controllers;

use Exception;
use V2\Modules\Time;
use V2\Modules\User;
use V2\Database\Querys;
use V2\Modules\JsonResponse;
use V2\Interfaces\IController;

class HistoryController implements IController
{
    private const VIDEO_DATA = [
        'video_id', 'name'
    ];

    public static function index($req): void
    {
        $arrayHistory = Querys::table('history')
            ->select(self::HISTORY_COLUMNS)
            ->where('user_id', User::$id)
            ->group($req->params->nro, $req->params->order)
            ->getAll(function () {
                throw new Exception('history not exist', 404);
            });

        foreach ($arrayHistory as $history) {
            $history->video = Querys::table('videos')
                ->select(self::VIDEO_DATA)
                ->where('video_id', $history->video)
                ->get();

            $_arrayHistory[] = $history;
        }

        JsonResponse::read($_arrayHistory);
    }

    public static function show($req): void
    {
        $history = Querys::table('history')
            ->select(self::HISTORY_COLUMNS)
            ->where([
                'user_id' => User::$id,
                'video' => $req->params->id
            ])->get(function () {
                throw new Exception('history not found', 404);
            });

        $history->video = Querys::table('videos')
            ->select(self::VIDEO_DATA)
            ->where('video_id', $history->video)
            ->get();

        JsonResponse::read($history);
    }

    public static function store($req): void
    {
        $video_id = $req->params->id;
        $historyQuery = Querys::table('history');

        $total_views = $historyQuery
            ->select('total_views')
            ->where([
                'user_id' => User::$id,
                'video' => $video_id
            ])->get();

        if ($total_views > 0) {
            $historyQuery->update($history = [
                'total_views' => ++$total_views,
                'create_date' => Time::current()->utc
            ])->where([
                'user_id' => User::$id,
                'video' => $video_id
            ])->execute();
        } else {
            $historyQuery->insert($history = [
                'user_id' => User::$id,
                'video' => $video_id,
                'total_views' => 1,
                'create_date' => Time::current()->utc
            ])->execute();
        }

        $views = Querys::table('videos')
            ->select('total_views')
            ->where('video_id', $video_id)
            ->get();

        Querys::table('videos')->update([
            'total_views' => ++$views
        ])->where('video_id', $video_id)
            ->execute();

        $path = SERVER_URL . "/history/{$video_id}";

        JsonResponse::created($history, $path);
    }

    public static function update($req): void
    { }

    public static function destroy($req): void
    {
        $historyQuery = Querys::table('history');

        if (isset($req->params->id)) {
            $historyQuery->delete()
                ->where([
                    'user_id' => User::$id,
                    'video' => $req->params->id
                ])->execute(function () {
                    throw new Exception('history not found', 404);
                });
        } else {
            Querys::table('history')->select('user_id')
                ->where('user_id', User::$id)
                ->get(function () {
                    throw new Exception('history not exist', 404);
                });

            $historyQuery->delete()
                ->where('user_id', User::$id)
                ->execute();
            // ERROR: se debe investigar porque $row devuelve 0 al aplicar un DELETE FROM en la tabla history
        }

        JsonResponse::removed();
    }
}
