desc "Import wish list"
task :ca_import, [:ca_username] => :environment do |t, args|
      require 'mechanize'
  # agent = WWW::Mechanize.new
  
  # agent.get("http://railscasts.tadalist.com/session/new")
  # form = agent.page.forms.first
  # form.password = "secret"
  # form.submit
  
  # agent.page.link_with(:text => "Wish List").click
  # agent.page.search(".edit_item").each do |item|
  #   Product.create!(:name => item.text.strip)
  # end



        mechanize = Mechanize.new

        uri = "https://www.codecademy.com/" + args[:ca_username]

        page = mechanize.get(uri)


        # form = page.forms.first

        # username_field = form.field_with(:name => "user[login]")
        # username_field.value = "pwjablonski"
        # password_field = form.field_with(:name => "user[password]")
        # password_field.value = "Diannao91"
        # result_page = form.submit

        codecademy_data = []
        page.search('h3').each do |h3|
            codecademy_data << h3.text
        end

        print codecademy_data


end

task :ca_lab_import => :environment do |t, args|
      require 'mechanize'
  # agent = WWW::Mechanize.new
  
  # agent.get("http://railscasts.tadalist.com/session/new")
  # form = agent.page.forms.first
  # form.password = "secret"
  # form.submit
  
  # agent.page.link_with(:text => "Wish List").click
  # agent.page.search(".edit_item").each do |item|
  #   Product.create!(:name => item.text.strip)
  # end



        mechanize = Mechanize.new

        uri = "https://www.codecademy.com/login?redirect=%2Fschools%2Fcurriculum%2Flabs%2F55f6f2e6d3292fdf93000160"

        page = mechanize.get(uri)


        form = page.forms.first

        username_field = form.field_with(:name => "user[login]")
        username_field.value = "programs@weare.ci"
        password_field = form.field_with(:name => "user[password]")
        password_field.value = "oconnell"
        results_page = form.submit

        codecademy_data = []
        results_page.search('td').each do |td|
            codecademy_data << td.text
        end

        puts codecademy_data


end