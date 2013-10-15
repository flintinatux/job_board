class NewJob.Models.Job extends Backbone.Model
  defaults:
    'category_id':  CurrentBoard.categories[0].id
    'highlight':    null

    'title': 'Nurse Technician'
    'company': 'Floyd Medical Center'
    'location': 'Rome, GA'
    'url': 'http://floyd.org'
    'description': 'We are current seeking an **experienced Registered Nurse** in our 48 bed Medicine Unit. This is a three 12 hour Night shift position. The 5C unit is a 48 bed medicine unit with an additional 5-bed direct admit unit. Our average daily census is 32-35 patients our nursing ratios are 1-5 on days and 1-6 on nights. There are 4 CANMs two for each shift that are out of staffing. Our average length of stay for our patients is about 3-4 days.\n\nWe have a very strong sense of team work on our unit. We are very busy and often discharge and admit on average 10 patients daily. Our nurses are supported with ACTs who carry 1-10 ratio. They usually have 8 patients. Our isolation rates run at approximately 30% of the patient population.\n\nQualified candidates should apply.'
    'instructions': 'Send a resume to mark@plasticsurgery.com'
    'email': 'resumes@floyd.org'

  validation:
    title:
      required: true
      msg: 'Please enter the job title.'
    location:
      required: true
      msg: "Please enter your company's location."
    description:
      required: true
      msg: 'Please enter the job description.'
    instructions:
      required: true
      msg: 'Please explain how a candidate can apply for your job.'
    company:
      required: true
      msg: 'Please enter your company name.'
    url:
      pattern:  'url'
      required: false
      msg: 'Please enter a valid url.'
    email:
      required: true
      pattern:  'email'
      msg: 'Please enter a valid email.'
