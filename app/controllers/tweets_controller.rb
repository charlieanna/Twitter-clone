class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.new(tweet_params)
    serializer = TweetSerializer.new @question
    @my_callback = lambda { |m| "nothing" }

    ## Execute Publish
    @pubnub.publish(
        :channel  => event.code,
        :message  => {tweet:serializer,action:"create"},
        :callback => @my_callback
    )
    render nothing: true
        # respond_to do |format|
        #   if @tweet.save
        #     format.html { redirect_to dashboard_path, notice: 'Tweet was successfully created.' }
        #     format.json { render :show, status: :created, location: @tweet }
        #   else
        #     format.html { render :new }
        #     format.json { render json: @tweet.errors, status: :unprocessable_entity }
        #   end
        # end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def retweet
    tweet = Tweet.find(params[:tweet_id])
    retweet = current_user.tweets.new
    retweet.status = tweet.status
    #retweet.message = "RT by {tweet.user}"
    retweet.retweet_id = tweet.id
    retweet.save
    serializer = TweetSerializer.new @question
    @my_callback = lambda { |m| "nothing" }

    ## Execute Publish
    @pubnub.publish(
        :channel  => event.code,
        :message  => {tweet:serializer,action:"retweet"},
        :callback => @my_callback
    )
    render nothing: true
  end

  def favorite
    tweet = Tweet.find(params[:tweet_id])
    current_user.favorites << tweet
    serializer = TweetSerializer.new @question
    @my_callback = lambda { |m| "nothing" }

    ## Execute Publish
    @pubnub.publish(
        :channel  => event.code,
        :message  => {tweet:serializer,action:"favorite"},
        :callback => @my_callback
    )
    render nothing: true
  end

  def unfavorite
    tweet = Tweet.find(params[:tweet_id])
    current_user.favorites.delete(tweet)
    serializer = TweetSerializer.new @question
    @my_callback = lambda { |m| "nothing" }

    ## Execute Publish
    @pubnub.publish(
        :channel  => event.code,
        :message  => {tweet:serializer,action:"unfavorite"},
        :callback => @my_callback
    )
    render nothing: true
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    serializer = TweetSerializer.new @question
    @my_callback = lambda { |m| "nothing" }

    ## Execute Publish
    @pubnub.publish(
        :channel  => event.code,
        :message  => {tweet:serializer,action:"destroy"},
        :callback => @my_callback
    )
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:status, :user_id)
    end
end
