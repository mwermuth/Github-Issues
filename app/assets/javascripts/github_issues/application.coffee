unless jQuery?
  throw "Github Issues Error: jQuery needs to be loaded for Github Issues to work."

unless jQuery.ui?
  throw "Github Issues Error: jQuery UI needs to be loaded for Github Issues to work."

window.GitHubIssue

jQuery ->

  if $("#new_github_issue_link").length > 0

    $("body").append("<div id='new_github_issue_dialog' title='New Issue'></div>")

    $("#new_github_issue_dialog").dialog
      modal: true
      autoOpen: false
      width: 450
      height: 350
      buttons: 
        "okay": ->
          console.log 'okay, clicked'
          $(@).dialog 'close'
        "cancel": ->
          $(@).dialog 'close'

    $("#new_github_issue_link").live 'click', (e) ->
      e.preventDefault()
      $("#new_github_issue_dialog").dialog 'open'
