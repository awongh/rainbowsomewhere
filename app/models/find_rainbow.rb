class FindRainbow < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :duration_seconds

  def initialize( latitude, longitude )
    @latitude = latitude
    @longitude = longitude
  end

  def find 
    return_value = nil
    # forecast = Forecast::IO.forecast( 37.8267, -122.423 )

    return nil if @latitude == nil || @longitude == nil

    forecast = Forecast::IO.forecast( @latitude, @longitude )

    #what happens if this request fails?

    if forecast.flags['darksky-unavailable'] == true || forecast == nil
      return nil
    end

    #what time of day is it?
    #what are the general conditions right now?

    today = forecast.daily.data.first

    if today.sunriseTime > forecast.currently.time || 
      today.sunsetTime < forecast.currently.time ||
      forecast.currently.precipType == 'snow' ||
      forecast.currently.precipType == 'hail' ||
      forecast.currently.precipType == 'sleet' || 
      forecast.currently.cloudCover == 1 || 
      forecast.currently.visibility < 1 

      return nil
    end

    #we probably want a measure of rate of change of the weather prediction
    #minutes / ( prob* 10 ) = rate of change
    #
    change = Array.new 
    total_change = 0

    forecast.minutely.data.each do |minute|

      if change.count() >= 30
        change.pop()
      end

      #p minute.precipProbability
      change.push( minute.precipProbability )

      change.each_with_index do |precip,i|
        next if ! precip

        if ( precip - change.first ).abs > 0.5 
          #we have a winner. stop here
          return i
        end

        v = precip - change.first
        #p "= " + v.to_s
      end

    end
    return_value

  end


  def sunangle
    puts "foo"

  end


end
