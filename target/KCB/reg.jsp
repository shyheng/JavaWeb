<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="dao.Dao" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <style type="text/css">
        body {
            /*background-image: url();*/
            background-repeat: no-repeat;
            /* 当内容高度大于图片高度时，背景图像的位置相对于viewport固定 */
            background-attachment: fixed; /*此条属性必须设置否则可能无效*/
            /* 让背景图基于容器大小伸缩 */
            background-size: cover;
            /* 设置背景颜色，背景图加载过程中会显示背景色 */
            background-color: #CCCCCC;
        }

        #user_reg {
            font-family: 微软雅黑;
            font-size: 40px;
            text-align: center;
            margin-top: 200px;
        }

        form {
            width: 500px; /*设置宽度，方便使其居中*/
            margin: 40px auto auto auto; /*上右下左*/
            font-size: 25px;
        }

        input {
            height: 30px;
            width: 12em;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        /*input标签下的属性选择器*/
        input[type="submit"], input[type="reset"] {
            height: 25px;
            width: 5em;
            margin-top: 5px;
            margin-left: 6px;
        }
    </style>

</head>
<script type="text/javascript">

    function validate_password(password) {
        var passwordReg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$/;
        if (password != "" && password.search(passwordReg) != -1) {
            document.getElementById("test_pw").innerHTML = "<font color='green' size='3px'>√密码格式正确</font>";
        } else {
            document.getElementById("test_pw").innerHTML = "<font color='red' size='3px'>密码格式错误</font>";
            alert("密码有6位，由数字和字母组成!");
        }
    }

    //函数3：验证两次输入的密码是否一样
    function validate_password2(password2) {
        var password = document.getElementById("password").value;
        if (password == "") {
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>密码不为空</font>";
        } else if (password == password2) {
            document.getElementById("is_test_pw").innerHTML = "<font color='green' size='3px'>√两次输入的密码相同</font>";
        } else {
            document.getElementById("is_test_pw").innerHTML = "<font color='red' size='3px'>两次输入的密码不相同</font>";
        }
    }

    //函数4：验证表单是否已经填好
    function validate_form() {
        var password = document.getElementById("password").value;
        var password2 = document.getElementById("password2").value;
        var passwordReg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6}$/;
        if (password != "" && passwordReg.test(password)) {
            if (password2 == password) {
                return true;
            } else {
                alert("密码不一致，提交失败，请重新填写！");
                return false;
            }
        } else {
            alert("密码格式错误，提交失败，请重新填写！");
            return false;
        }

    }
</script>

<body>

<div id="user_reg">用户注册:</div>
<form action="/reg" method="post" name="form">

    <table style="margin-left: 20%">
        <tr>
            <td>请输入账号：</td>
            <td><input type="text" id="username" name="username" placeholder="输入用户名"/></td>
            <td id="test_user">
                <font style="color: red;size:3px">
                    <%
                        String result =(String) request.getAttribute("info");
                        if (result == null){
                            result = "";
                        }
                    %>
                <%=result%>
            </font>
            </td>
        </tr>
        <tr>
            <td>请输入密码：</td>
            <td><input type="password" id="password" name="password" placeholder="6位密码由数字和字母组成"
                       onblur="validate_password(this.value)"/></td>
            <td id="test_pw"></td>
        </tr>
        <tr>
            <td>请确认密码：</td>
            <td><input type="password" id="password2" name="password2" onblur="validate_password2(this.value)"/></td>
            <td id="is_test_pw"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" id="submit_form" value="注册" onclick="return validate_form()"/>
                <input type="reset" value="重置"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>