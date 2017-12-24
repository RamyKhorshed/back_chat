class Api::V1::WatsonInsightsController < ApplicationController
  def show

    username = ENV["username"]
    password = ENV["password"]

    user = User.all.find_by_username(params[:id])

    content = user.all_conversations

    response = Excon.post("https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2017-10-13",
      body: content,
      headers: { "Content-Type": "text/plain" },
      user: username,
      password: password,
      query: {
         "raw_scores": true,
         "consumption_preferences": true,
         "version": "2017-10-13"
      }
    )

    insights = JSON.parse(response.body)
    new_insight = WatsonInsight.create(insight: insights, user_id: user.id)
    user.watson_insights << new_insight

    render json: { personality_insights: insights }
  end
end
