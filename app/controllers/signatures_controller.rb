class SignaturesController < ApplicationController
#  skip_before_action :verify_authenticity_token, only: [:callbacks]



#    def authorize
#        redirect_to "https://secure.na1.echosign.com/public/oauth?redirect_uri=https://weareci.herokuapp.com/events/&response_type=code&client_id=CBJCHBCAABAAXTQdZQjOfCXBUwVnTynIiynrwVsXGVl_&scope=agreement_send"
#        
#    end
#    
    def callbacks
        code = params[:code]
        
        response = HTTParty.post("https://api.na1.echosign.com/oauth/token?code=#{code}&client_id=CBJCHBCAABAAXTQdZQjOfCXBUwVnTynIiynrwVsXGVl_&client_secret=4FhKpvbTj0k0_9dd_qkfgL8GXsUIg8XB&redirect_uri=https://weareci.herokuapp.com/signatures/callbacks&grant_type=authorization_code")
        
        puts response.parsed_response
        puts response.parsed_response["access_token"]
        
        
        session[:token] = response.parsed_response["access_token"]
        
        
        puts session[:token]
       
        
        redirect_to events_path
    end


    def authorize_adobe
        
        redirect_to "https://secure.na1.echosign.com/public/oauth?redirect_uri=https://weareci.herokuapp.com/signatures/callbacks&response_type=code&client_id=CBJCHBCAABAAXTQdZQjOfCXBUwVnTynIiynrwVsXGVl_&scope=agreement_send:self"
    end
    
    def sendsigrequest
              @event = Event.find(params[:event_id])
              @registration = Registration.find(params[:registration_id])
              
            puts "Session TOKEN #{session[:token]}"
    
            response = HTTParty.get("https://api.na1.echosign.com/api/rest/v5/agreements",
                                    :headers => {"Access-Token" => session[:token]},
                             
                            :query => { "AgreementCreationInfo" =>
                             {
                                "documentCreationInfo"=>
                                     {
                                    "name"=> "Test Document",
                                    "message"=> "This is a test",
                                    "recipientSetInfos"=> [
                                        {
                                            "recipientSetRole"=> "SIGNER",
                                            "recipientSetMemberInfos"=> [
                                                {
                                                    "email"=> "pwjablonski@gmail.com"
                                                }
                                            ]
                                        }
                                    ],
                                    "fileInfos"=> [
                                        {
                                            "documentURL"=>
                                                {
                                                    "name" => "file",
                                                    "url" => "https://bitcoin.org/bitcoin.pdf",
                                                    "mimeType" => "application/pdf"
                                                }
                                        }
                                    ],
                                    "signatureType"=> " ESIGN",
                                    "signatureFlow"=> "SENDER_SIGNATURE_NOT_REQUIRED",
                                    "securityOptions"=>
                                        {
                                            "passwordProtection"=> "NONE",
                                            "kbaProtection"=> "NONE",
                                            "webIdentityProtection"=> "NONE",
                                            "protectOpen"=> false,
                                            "internalPassword"=> "",
                                            "externalPassword"=> "",
                                            "openPassword"=> ""
                                        }
                                    }
                             }
                        }
            )
            
            
            
            puts response
            
            redirect_to @event
    end


#  def callbacks
#    render json: 'Hello API Event Received', status: 200
#  end
#
#
#  def new
#      @event_id = params[:event_id]
#  end
#
#  def create
##      embedded_request = create_embedded_request(name: params[:name], email: params[:email], file_url: params[:file_url])
##      @sign_url = get_sign_url(embedded_request)
##      render :embedded_signature
#  end
#
#
#  def sendsigrequest
#      @event = Event.find(params[:event_id])
#      @registration = Registration.find(params[:registration_id])
#      
#      if @registration.signature_request_id == nil
#          signature_request = send_signature_request(@registration, @event)
#          @registration.update_attribute(:signature_request_id, signature_request.signature_request_id)
#          redirect_to @event
#      else
#          redirect_to @event
#      end
#                                         
#  end
#      
#
#  private
#
#    def send_signature_request(registration, event)
#        
#        signature_request = HelloSign.send_signature_request(
#                                         :test_mode => 1,
#                                         :title => 'Test Signature',
#                                         :subject => 'PLease sign the this',
#                                         :message => 'Please sign this and then we can discuss more. Let me know if you have any
#                                         questions.',
#                                         :signers => [
#                                         {
#                                         :email_address => registration.student.user.email,
#                                         :name => "#{registration.student.first_name} #{registration.student.last_name} "
#                                         }
#                                         ],
#                                         :file_urls => [event.permission_url]
#                                         )
#        return signature_request
#    end
#
#  def create_embedded_request(opts = {})
#    HelloSign.create_embedded_signature_request(
#      test_mode: 1, #Set this to 1 for 'true'. 'false' is 0
#      client_id: 'f72982478d6230927805fbb87c36daf4',
#      subject: 'My first embedded signature request',
#      message: 'Awesome, right?',
#      signers: [
#        {
#          email_address: opts[:email],
#          name: opts[:name]
#        }
#      ],
#      :file_urls => ["https://bitcoin.org/bitcoin.pdf"]
#    )
#  end
#
#  def get_sign_url(embedded_request)
#    sign_id = get_first_signature_id(embedded_request)
#    HelloSign.get_embedded_sign_url(signature_id: sign_id).sign_url
#  end
#
#  def get_first_signature_id(embedded_request)
#    embedded_request.signatures[0].signature_id
#  end
#  

end
