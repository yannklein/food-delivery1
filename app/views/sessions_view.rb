class SessionsView
  def ask_for(something)
    puts "#{something.capitalize}下さい！"
    gets.chomp
  end

  def wrong_pwd
    puts "Wrong password"
  end
end