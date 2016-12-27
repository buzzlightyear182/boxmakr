$(document).ready(function(){

  var url

  $('.item-checkbox input[type=checkbox').change(function(){
    if (this.checked){
      url = setUrl(this, 'add')
      console.log(url)
    }
    else {
      url = setUrl(this, 'remove')
    }

    $.post(url, function(data){
    })

  })

  function setUrl(checkbox, action){
    if (action === 'add'){
      console.log($(checkbox).data('box-id'));
      console.log($(checkbox).data('item-id'));
      return $(checkbox).data('box-id') + "/add_item/" +  $(checkbox).data('item-id') + ".js"
    }
    else if (action === 'remove') {
      return $(checkbox).data('box-id') + "/remove_item/" +  $(checkbox).data('item-id') + ".js"
    }
    else {
      alert("Error!!");
    }
  }
});