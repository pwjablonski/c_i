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
        
        puts "MY TOKEn " + response.access_token
        
        session[:token] = response.access_token
        
        redirect_to events_path
    end


    def authorize_adobe
        
        redirect_to "https://secure.na1.echosign.com/public/oauth?redirect_uri=https://weareci.herokuapp.com/signatures/callbacks&response_type=code&client_id=CBJCHBCAABAAXTQdZQjOfCXBUwVnTynIiynrwVsXGVl_&scope=agreement_send"
    end
    
    def sendsigrequest
              @event = Event.find(params[:event_id])
              @registration = Registration.find(params[:registration_id])
    
    
            response = HTTParty.post("https://api.na1.echosign.com/api/rest/v5/",
                             :header => {"Access-Token" => "3AAABLblqZhDaGCwkX4DnfpQ-UiMtCwAYCz6f3k5ggbtFr1USk_dY31hDV9VPBOIlcEYiLyaMtV049w3pi_oQaKneiIItPCTi"},
                             
                            :body => { "AgreementCreationInfo" => session[:token]
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
                                            "transientDocumentId"=> "3AAABLblqZhCyvMjiP_RA04XJwbqV7u77Jssvfzr3yM8gG8f4U1YK4heYTZSQay5hf_bI_jId-j3HY9LHsFMcXFeNwJ7wIaDod4HWlC9Cf9M87oUmJ5-kHb35x9VxD_X4EuKlQoqMYJ3tO086IOjg1DmNSP7dTs5a50gSciBCyo3iBRQKf0_bKLorX4E_4Lt4RAivgSU5tAwAWZrXfZ6t5g1U6b8XRf21af-rYNOiPB94rUZFlBz-bOsdFKzpiRfCNDkfO8bs1mw*"
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
