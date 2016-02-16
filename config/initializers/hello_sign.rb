require 'hello_sign'
HelloSign.configure do |config|
    config.api_key = 'da952788ca64bec4e791ab5afe510bb927fb61dd5c5dd96460cea655dce70164'
    config.client_id = 'f72982478d6230927805fbb87c36daf4'
    # You can use email_address and password instead of api_key. But api_key is recommended
    # If api_key, email_address and password are all present, api_key will be used
    # config.email_address = 'email_address'
    # config.password = 'password'
end