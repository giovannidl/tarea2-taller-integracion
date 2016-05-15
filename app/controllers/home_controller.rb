require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def search_tag
    url = 'https://api.instagram.com/v1/tags/{tag-name}/media/recent?access_token=ACCESS-TOKEN'
    count_url = 'https://api.instagram.com/v1/tags/{tag-name}?access_token=ACCESS-TOKEN
'
    if params[:tag].present? and params[:access_token].present?
      url.sub! 'ACCESS-TOKEN', params[:access_token]
      count_url.sub! 'ACCESS-TOKEN', params[:access_token]
      url.sub! '{tag-name}', params[:tag]
      count_url.sub! '{tag-name}', params[:tag]
      result = JSON.load(open(url))
      count_result = JSON.load(open(count_url))
      if result['meta']['code'] == 200 and count_result['meta']['code'] == 200
        post_list = get_post(result['data'])
        post_json = {
            metadata: {
                total: count_result['data']['media_count']
            },
            posts: post_list,
            version: '1.0.0'
        }
        render json: post_json, status: result['meta']['code']
      else
        render json: result, status: result['meta']['code']
      end
    else
      render json: {}, status: :bad_request
    end
  end

  private
  def get_post(data)
    post_list = []

    data.each do |post|
      new_post = {
          tags: post['tags'],
          username: post['user']['username'],
          likes: post['likes']['count'],
          url: post[post['type'].pluralize]['standard_resolution']['url'],
          caption: post['caption']['text']
      }
      post_list.push(new_post)
    end
    post_list
  end
end
