class SignaturesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    render json: 'Hello API Event Received', status: 200
  end


  def new
  end

  def create
  embedded_request = create_embedded_request(name: params[:name], email: params[:email])
  @sign_url = get_sign_url(embedded_request)
  render :embedded_signature
  end

  private

  def create_embedded_request(opts = {})
    HelloSign.create_embedded_signature_request(
      test_mode: 1, #Set this to 1 for 'true'. 'false' is 0
      client_id: 'f72982478d6230927805fbb87c36daf4',
      subject: 'My first embedded signature request',
      message: 'Awesome, right?',
      signers: [
        {
          email_address: opts[:email],
          name: opts[:name]
        }
      ],
      :file_urls => ['https://bitcoin.org/bitcoin.pdf']
    )
  end

  def get_sign_url(embedded_request)
    sign_id = get_first_signature_id(embedded_request)
    HelloSign.get_embedded_sign_url(signature_id: sign_id).sign_url
  end

  def get_first_signature_id(embedded_request)
    embedded_request.signatures[0].signature_id
  end

end
