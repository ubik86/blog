class Stat

  include ActiveModel::Model

  attr_accessor :posts, :comments
  attr_accessor :given_period

  def initialize(arg = :year)
    @given_period = arg
  end

  # return count of Posts and Comments for given period
  def period(arg=nil)
     arg ||= @given_period
    { post: Post.where(created_at: 1.send(arg).ago .. Time.now).size, comment: Comment.where(created_at: 1.send(arg).ago .. Time.now).size }
  end

  # return all stats for year, month, week, day
  def all
    stat = {}
    [:year, :month, :week, :day].map{|i| stat[i] = period(i)}

    return stat
  end

  # method_missing for yearly, monthly, weekly and daily
  def method_missing(method_sym, *arguments, &block)
    # the first argument is a Symbol, so you need to_s it if you want to pattern match
    if method_sym.to_s =~ /(.*.)ly$/
      $1 != 'dai' ? period($1.to_sym) : period(:day)
    else
      super
    end
  end

end