# frozen_string_literal: true

def wait_until
  require 'timeout'
  Timeout.timeout(5) do
    sleep(5) until value = yield
    value
  end
end
