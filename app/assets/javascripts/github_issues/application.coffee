unless jQuery?
  throw "Github Issues Error: jQuery needs to be loaded for Github Issues to work."

unless jQuery.ui?
  throw "Github Issues Error: jQuery UI needs to be loaded for Github Issues to work."

window.GitHubIssue

jQuery ->

  if $("#new_github_issue_link").length > 0

    $("#new_github_issue_dialog").dialog
      modal: true
      autoOpen: false
      width: 500
      height: 450
      buttons: 
        "okay": ->
          console.log 'okay, clicked'
          params = $("#new_github_issue_form").serialize()
          url = "/github_issues/issues"
          $.post url, params, 'script'
        "cancel": ->
          $('#github_issues_issue_title').val('')
          $('#github_issues_issue_message').val('')
          $('#new_github_issue_form > #errorExplanation').remove()
          $(@).dialog 'close'

    $("#new_github_issue_link").live 'click', (e) ->
      e.preventDefault()
      $("#new_github_issue_dialog").dialog 'open'
