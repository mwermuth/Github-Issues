unless jQuery?
  throw "Github Issues Error: jQuery needs to be loaded for Github Issues to work."

unless jQuery.ui?
  throw "Github Issues Error: jQuery UI needs to be loaded for Github Issues to work."

window.GithubIssues =
  
  clearForm: ->
    $('#github_issues_issue_title').val('')
    $('#github_issues_issue_body').val('')
    $('#new_github_issue_form > .errorExplanation').remove()

  submitForm: ->
    params = $("#new_github_issue_form").serialize()
    url = "/github_issues/issues"
    $.post(url, params, 'script')

  showDialogIndMsg: (dialog, msg="submitting") ->
    dialog.parent().find(".ui-dialog-buttonset").hide()
    if dialog.parent().find(".dialog_ind_msg").length > 0
      dialog.parent().find(".dialog_ind_msg").html(msg).show()
    else 
      dialog.parent().append($("<div>" + msg + "</div>").addClass("github_issues_dialog_ind_msg"))
  
  hideDialogIndMsg: (dialog) ->
    dialog.parent().find(".ui-dialog-buttonset").show()
    dialog.parent().find(".github_issues_dialog_ind_msg").hide()

jQuery ->

  if $("#new_github_issue_link").length > 0

    $('#github_issues_issue_title').on 'keypress', (e) ->
      code = if e.keyCode then e.keyCode else e.which
      if code == 13
        e.preventDefault()

    $("#new_github_issue_dialog").dialog
      modal: true
      autoOpen: false
      width: 500
      buttons: 
        "okay": ->
          GithubIssues.showDialogIndMsg($(@))
          setTimeout ->
            GithubIssues.submitForm()
          , 500
        "cancel": ->
          GithubIssues.clearForm()
          $(@).dialog 'close'

    $("#github_issue_submitted_successfully_dialog").dialog
      modal: true
      autoOpen: false
      width: 300
      buttons: 
        "okay": ->
          $(@).dialog 'close'

    $("#new_github_issue_link").on 'click', (e) ->
      e.preventDefault()
      $("#new_github_issue_dialog").dialog 'open'
