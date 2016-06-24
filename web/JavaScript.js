function checkEmpty(){
    var user = form.user.value;
    var pass = form.pass.value;

    if (user == ""){
        alert("You can not login without Username!");
        form.user.focus();
    }
    else if (pass == ""){
        alert("You can not login without Password!");
        form.pass.focus();
    }
    else
        loginCheck();
}

function initRequest() {
    var xRequest=null;
    if (window.XMLHttpRequest) {                        
        xRequest=new XMLHttpRequest();   
    }else if (typeof ActiveXObject != "undefined"){     
        xRequest=new ActiveXObject("Microsoft.XMLHTTP");   
    }
    return xRequest;
}

function postRequest(URL){
    var xmlHttp = initRequest() ;
    xmlHttp.open('POST', URL, true);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.onreadystatechange = function(){
        if (xmlHttp.readyState == 4){
            message(xmlHttp.responseText);
        }
    }
    xmlHttp.send(URL);
}

function message(response){
    if(response == "Invalid"){
        alert("Wrong Username or Password falied, please try again!");
        form.user.value = "";
        form.pass.value = "";
        
    }else if (response == "Logout"){
        alert("You just logged out successfully!");
        document.getElementById("head").innerHTML = "<meta http-equiv=refresh content=0;URL=index.html>";
    }
    else if (response == "Student"){
        document.getElementById("head").innerHTML = "<meta http-equiv=refresh content=0;URL=StudentIndex.jsp>";
    }
    else if (response == "Manager"){
        document.getElementById("head").innerHTML = "<meta http-equiv=refresh content=0;URL=ManagerIndex.jsp>";
    }
    else{
        openPopUp(response);
    }
}

function loginCheck(){
    var user = document.form.user.value;
    var pass = document.form.pass.value;
    var URL = "LoginCheck?user=" + user +"&pass=" + pass;
    postRequest(URL);
}

function createCookie(name, value) {
    document.cookie = name + "=" + value;
}
                
function openPopUp(HTML){
    popup = window.open("", "", "left=625, top=150,width=750,height=500,status=no,toolbar=no,menubar=no,scrollbars=no");    
    popup.document.writeln(HTML);
}

function closePopUp(){
    if (!popup.closed)
        popup.self.close()
}