class VisitsController < ApplicationController
  include ActionController::Live

  before_action :set_visit, only: %i[ show update destroy ]
  skip_before_action :authenticate_user!, only: [:stream]

  # GET /visits
  def index
    render standard_json_response(serializer(filter_list), {}, :ok, [], "")
  end

  # GET /visits/1
  def show
    render standard_json_response(serializer(@visit), {}, :ok, [], "")
  end

  # POST /visits
  def create
    @visit = Visit.create!(visit_params)
    render standard_json_response(serializer(@visit), {}, :created, [], "")
  end

  # PATCH/PUT /visits/1
  def update
    @visit.update!(visit_update_params)
    render standard_json_response(serializer(@visit), {}, :ok, [], "")
  end

  # DELETE /visits/1
  def destroy
    @visit.destroy
    render standard_json_response({}, {}, :no_content, [], "")
  end

  def stream
    tracks = get_user_playlist
  
    # Set response headers for streaming
    response.headers['Content-Type'] = 'audio/mpeg'
    response.headers['Accept-Ranges'] = 'bytes'
  
    # Specify AWS credentials
    credentials = Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
  
    # Specify AWS region
    region = ENV["AWS_ACCESS_REGION"]
  
    # Stream the first track
    stream_track(tracks, 0, credentials, region)

    # Log data transfer
    Rails.logger.info("Data transferred: #{response.body.bytesize} bytes")
  ensure
    # Ensure the response stream is closed
    response.stream.close
  end
  
  private

  def stream_track(tracks, index, credentials, region)
    return if index >= tracks.length
  
    track = tracks[index]
    s3 = Aws::S3::Resource.new(
      region: region,
      credentials: credentials
    )
  
    bucket_name = ENV["AWS_ACCESS_BUCKET"]
    obj = s3.bucket(bucket_name).object(track[:file_key])
    Rails.logger.info "Streaming the song #{track[:file_key]}"
  
    # Set the content length for the current track
    #response.headers['Content-Length'] = obj.content_length
  
    # Get the content type (MIME type) of the object from S3
    # content_type = obj.content_type
  
    # Set the Content-Type header based on the MIME type fetched from S3
    # response.headers['Content-Type'] = content_type
  
    # Stream the current track from S3 using the read method
    obj.get(response_target: response) do |chunk|
      Rails.logger.info "Streaming chunk..."
      response.stream.write(chunk)
    end
  
    # After streaming this track, recursively stream the next track
    stream_track(tracks, index + 1, credentials, region)
  end
  
  # def stream_track(tracks, index, credentials, region)
  #   puts "NOTHING TO STREAM" if index >= tracks.length
  #   return if index >= tracks.length
  
  #   track = tracks[index]
  #   s3 = Aws::S3::Resource.new(
  #     region: region,
  #     credentials: credentials
  #   )
  
  #   bucket_name = ENV["AWS_ACCESS_BUCKET"]
  #   obj = s3.bucket(bucket_name).object(track[:file_key])
  #   puts "Streaming the song #{track[:file_key]}"
  
  #   # Get the content type (MIME type) of the object from S3
  #   content_type = obj.content_type
  
  #   # Set the Content-Type header based on the MIME type fetched from S3
  #   response.headers['Content-Type'] = content_type
  
  #   # Set the content length for the current track
  #   response.headers['Content-Length'] = obj.content_length
  
  #   # Stream the current track from S3
  #   obj.get(response_target: Proc.new { |chunk| response.stream.write(chunk) }) do |response|
  #     # After streaming this track, recursively stream the next track
  #     response.stream.on_close do
  #       stream_track(tracks, index + 1, credentials, region)
  #     end
  #   end
  # end

  def get_user_playlist
    [
      {
        file_key: "medios/Music/ACDC-Back In Black.mp3"
      },
      {
        file_key: "medios/Music/ACDC-Highway to Hell.mp3"
      },
      {
        file_key: "medios/Music/ACDC-Play Ball.mp3"
      }
    ]
  end

  # def stream
  #   tracks = get_user_playlist

  #   # Set response headers for streaming
  #   response.headers['Content-Type'] = 'audio/mpeg'
  #   response.headers['Accept-Ranges'] = 'bytes'

  #   # Specify AWS credentials
  #   credentials = Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])

  #   # Specify AWS region
  #   region = ENV["AWS_ACCESS_REGION"]

  #   # Stream each track sequentially
  #   tracks.each do |track|
  #     s3 = Aws::S3::Resource.new(
  #       region: region,
  #       credentials: credentials
  #     )
      
  #     bucket_name = ENV["AWS_ACCESS_BUCKET"]
  #     obj = s3.bucket(bucket_name).object(track[:file_key])

  #     # Get the content type (MIME type) of the object from S3
  #     content_type = obj.content_type

  #     # Set the Content-Type header based on the MIME type fetched from S3
  #     response.headers['Content-Type'] = content_type

  #     # Set the content length for the current track
  #     response.headers['Content-Length'] = obj.content_length

  #     # Stream the current track from S3
  #     obj.get(response_target: Proc.new { |chunk| response.stream.write(chunk) })

  #   # Ensure the stream for the current track is closed properly
  #   ensure
  #     response.stream.close
  #   end
  # end

  # private

  # def get_user_playlist
  #   [
  #     {
  #       file_key: "medios/Music/ACDC-Back In Black.mp3"
  #     },
  #     {
  #       file_key: "medios/Music/ACDC-Highway to Hell.mp3"
  #     },
  #     {
  #       file_key: "medios/Music/ACDC-Play Ball.mp3"
  #     }
  #   ]
  # end

    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visit_params
      permitted_params = params.require(:visit).permit(:penalty_amount, :comments, :latitude, :longitude, :user_id, :customer_id)
      permitted_params[:user_id] = current_user.id if current_user

      permitted_params
    end

    def visit_update_params
      params.require(:visit).permit(:penalty_amount, :status)
    end

    def filter_list
      filters = {
        customer_id: params[:customer_id],
        user_id: params[:user_id],
        status: params[:status]
      }
      paginate Visit.filter(filters), per_page: per_page_params
    end

    def serializer(resources, view: nil)
      VisitSerializer.render_as_hash(resources, view: view)
    end
end
