# enable tab completion
require 'irb/completion'

# customize prompt as simplisic
#IRB.conf[:PROMPT_MODE] = :SIMPLE

# use ruby-wirble
begin
  # load and initialize wirble
  require 'wirble'
  Wirble.init
  # # Uncomment the line below to enable Wirble colors.  #
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end
