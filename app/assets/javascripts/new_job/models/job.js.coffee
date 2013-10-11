class NewJob.Models.Job extends Backbone.Model
  defaults:
    'category_id':  CurrentBoard.categories[0].id
    'highlight':    null

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
