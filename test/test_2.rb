require 'ruby-jmeter'

test do
  defaults domain: 'localhost:3000'
  cache clear_each_iteration: true
  cookies
  threads 50, {ramp_time: 60, duration: 120, continue_forever: true} do
    random_timer 1000, 3000
    extract name: 'authenticity_token',
            regex: 'meta content="(.+?)" name="csrf-token"'

  transaction '01_visit_home_page' do
      visit '/' do
        assert contains: 'HeartBeat'
      end
    end

    transaction '02_login' do
      submit '/attempt_login', {
          fill_in: {
              'utf8'                            => '%E2%9C%93',
              'authenticity_token'              => '${authenticity_token}',
              'session[email]'                  => 'sam@gmail.com',
              'session[password]'               => 'adminpassword',
              'commit'                          => 'Login',
      }
      }
    end
  end
end.jmx