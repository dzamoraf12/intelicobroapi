module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def create_json_standard_response(json_data, code, errors, backtrace)
    {
      json: {
        response: json_data,
        errors: errors,
        backtrace_error: backtrace
      },
      status: code
    }
  end
end