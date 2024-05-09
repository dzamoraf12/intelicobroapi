class ChunkSizeCheckerMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    # Wrap the response body with a proxy that tracks the size of each chunk
    response_body = ChunkSizeProxy.new(response) 

    [status, headers, response_body]
  end

  # Proxy class to wrap the response body and track chunk sizes
  class ChunkSizeProxy
    def initialize(response)
      @response = response
      @total_chunk_size = 0
    end

    def each(&block)
      @response.each do |chunk|
        # Calculate the size of each chunk
        chunk_size = chunk.bytesize
        
        # Log the size of each chunk
        Rails.logger.info "Chunk size: #{chunk_size} bytes"
        
        # Increment the total chunk size
        @total_chunk_size += chunk_size
        
        # Pass the chunk to the original response block
        block.call(chunk)
      end

      # Log the total sum of all the chunks
      Rails.logger.info "Total chunk size: #{@total_chunk_size} bytes"
    end

    # Override method_missing to delegate unknown methods to the original response
    def method_missing(method, *args, &block)
      @response.send(method, *args, &block)
    end

    # Ensure respond_to? returns true for all methods from the original response
    def respond_to_missing?(method, include_private = false)
      @response.respond_to?(method, include_private)
    end
  end
end