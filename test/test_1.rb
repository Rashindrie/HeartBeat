require 'ruby-jmeter'

#extract name: 'csrf-token',
      #  regex: 'meta content="(.+?)" name="csrf-token"'

test do
  threads count: 10 do
    visit name:'HeartBeat/login',  url: 'http://localhost:3000/login' do
      extract regex: "content='(.+?)' name='csrf-token'", name: 'csrf-token'
      think_time 3000
    end
  end
end.jmx(file: "/tmp/login_page.jmx")


test1 do
  user_defined_variables [{name: 'email', value: sam@gmail.com}, {name: 'password', value: adminpassword}]

  visit name: 'login page', url: 'http://localhost:3000/login' do
    extract name: 'csrf-token', xpath: "//meta[@name='csrf-token']/@content", tolerant: true
    extract name: 'csrf-param', xpath: "//meta[@name='csrf-param']/@content", tolerant: true
  end

  submit name: '/users/sign_in', url: '/attempt_login',
         fill_in: {
             '${csrf-param}' => '${csrf-token}',
             'user[email]' => '${email}',
             'user[password]' => '${password}',
         }
end