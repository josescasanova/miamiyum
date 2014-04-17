class SqootWrapper
  include HTTParty
  HTTParty.get('http://api.sqoot.com/v2/deals?api_key=l6frg7&location=Miami&categories=restaurants')
end