<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注销</title>
    <link rel="stylesheet" type="text/css" href="css/logout.css"/>
</head>
<body>
<script type="text/javascript">
    function validate_password2() {
        var password = document.getElementById("password").value;
        var password2 = document.getElementById("password2").value;
        if (password == ""||password2 == "") {
            alert("密码不为空")
            return false
        } else if (password == password2) {
            return true
        } else {
            alert("密码不一致，提交失败，请重新填写！");
            return false
        }
    }
</script>
<div id="login">
    <h1>注销</h1>
    <font style="color: red;size:3px">
        <%
            String result =(String) request.getAttribute("info");
            if (result == null){
                result = "";
            }
        %>
        <%=result%>
    </font>
    <form method="post" action="/logout">
        <input type="password" required="required" id="password" placeholder="密码" name="p"/>
        <input type="password" required="required" id="password2" placeholder="确认密码" name="p1"/>
        <button class="but" type="submit" onclick="validate_password2()">注销</button>
    </form>
</div>
</body>
</html>
