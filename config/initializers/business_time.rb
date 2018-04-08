#BusinessTime::Config.load("#{Rails.root}/config/business_time.yml")

# or you can configure it manually:  look at me!  I'm Tim Ferriss!
  BusinessTime::Config.beginning_of_workday = "9:00 am"
  BusinessTime::Config.end_of_workday = "3:00 pm"
	
	BusinessTime::Config.holidays << Date.parse("Jan 1st")
  BusinessTime::Config.holidays << Date.parse("Jun 5th")
	BusinessTime::Config.holidays << Date.parse("Dec 25th")
	BusinessTime::Config.holidays << Date.parse("Dec 26th")


	#Pinse 2018
	BusinessTime::Config.holidays << Date.parse("May 20th, 2018")
	BusinessTime::Config.holidays << Date.parse("May 21st, 2018")


	#store bededag 2018
	BusinessTime::Config.holidays << Date.parse("Apr 27th, 2018")

	#Kristi himelfartsdag 2018
	BusinessTime::Config.holidays << Date.parse("May 10th, 2018")



	#Easter 2019
	BusinessTime::Config.holidays << Date.parse("Apr 18th, 2019")
	BusinessTime::Config.holidays << Date.parse("Apr 19th, 2019")
	BusinessTime::Config.holidays << Date.parse("Apr 21st, 2019")
	BusinessTime::Config.holidays << Date.parse("Apr 22nd, 2019")

	#store bededag 2019
	BusinessTime::Config.holidays << Date.parse("May 17th, 2019")

	#Kristi himelfartsdag 2019
	BusinessTime::Config.holidays << Date.parse("May 30th, 2019")


	#Pinse 2019
	BusinessTime::Config.holidays << Date.parse("Jun 9th, 2019")
	BusinessTime::Config.holidays << Date.parse("Jun 10th, 2019")



