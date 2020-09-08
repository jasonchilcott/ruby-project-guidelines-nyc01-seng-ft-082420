require "tty-prompt"

$prompt = TTY::Prompt.new

$prompt.ask("Is tty running in console.rb?")