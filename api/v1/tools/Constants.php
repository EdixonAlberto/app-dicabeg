<?php

namespace Tools;

class Constants
{
   protected const SET_USERS = 'user_id, player_id, email, invite_code, registration_code, username, names, lastnames, age, avatar, phone, points, money, create_date, update_date';
   protected const SET_SESSIONS = 'user_id, api_token, expiration_time, create_date, update_date';
   protected const SET_REFERRALS = 'referred_id, create_date';
   protected const SET_HISTORY = 'history_id, user_id, video_id, history_views, update_date';
   protected const SET_VIDEOS = 'video_id, name, link, provider_logo, question, correct, responses, total_views, create_date, update_date';
}
