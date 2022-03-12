<%@ page import="dao.Dao" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="kcb.Kcb" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Date" %>
<%@ page import="static kcb.KcbWeek.getweek" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="static kcb.KcbWeek.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>课程表</title>
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/week.css"/>
    <style type="text/css">
        .login_click {
            height: 40px;
        }

        .login_click a {
            text-decoration: none;
            background: #2f435e;
            color: #f2f2f2;
            padding: 10px 30px 10px 30px;
            font-size: 16px;
            font-family: 微软雅黑, 宋体, Arial, Helvetica, Verdana, sans-serif;
            font-weight: bold;
            border-radius: 3px;
            -webkit-transition: all linear 0.30s;
            -moz-transition: all linear 0.30s;
            transition: all linear 0.30s;
        }

        .login_click a:hover {
            background: #385f9e;
        }
    </style>
</head>
<body>
<div id="tab">
    <table border="1" height="600px" width="100%">
        <%
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat dateFm = new SimpleDateFormat("EEEE");
            Date d = new Date();
            String startday = "2022-02-27";
            Date d1 = null;
            try {
                d1 = format.parse(startday);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            int weeks = getweek(d, d1);
            String currSun = dateFm.format(d);
        %>
        <div>
            <script type="text/javascript">
                let week = <%=weeks%>;
                let curr = '<%=currSun%>'

                function day() {
                    $.get("http://localhost:8080/time", function (data) {
                        $("#w_1").html("周一" + "<br>" + data[week - 1].w_1)
                        $("#w_2").html("周二" + "<br>" + data[week - 1].w_2)
                        $("#w_3").html("周三" + "<br>" + data[week - 1].w_3)
                        $("#w_4").html("周四" + "<br>" + data[week - 1].w_4)
                        $("#w_5").html("周五" + "<br>" + data[week - 1].w_5)
                        $("#w_6").html("周六" + "<br>" + data[week - 1].w_6)
                        $("#w_7").html("周日" + "<br>" + data[week - 1].w_7)
                    }, "json")
                }

                $(function () {
                    day()
                    $("#week").html("第" + week + "周")
                    $("#del").click(function () {
                        if (week > 1) {
                            week--
                            $("#week").html("第" + week + "周")
                            day()
                            $.get("http://localhost:8080/kcb?week="+week, function (data) {
                                for (let i = 0; i < data.length; i++) {
                                    let tableHtml;
                                    tableHtml += "<td>" + data[i].time + "</td>";
                                    tableHtml += "<td>" + data[i].monday + "</td>";
                                    tableHtml += "<td>" + data[i].tuesday + "</td>";
                                    tableHtml += "<td>" + data[i].wednesday + "</td>";
                                    tableHtml += "<td>" + data[i].thursday + "</td>";
                                    tableHtml += "<td>" + data[i].friday + "</td>";
                                    tableHtml += "<td>" + data[i].saturday + "</td>";
                                    tableHtml += "<td>" + data[i].sunday + "</td>";
                                    $("#" + (i + 1)).html(tableHtml)
                                }
                            })
                        }
                    })
                    $("#add").click(function () {
                        if (week < 18) {
                            week++
                        }
                        $("#week").html("第" + week + "周")
                        day()
                        $.get("http://localhost:8080/kcb?week="+week, function (data) {
                            for (let i = 0; i < data.length; i++) {
                                let tableHtml;
                                tableHtml += "<td>" + data[i].time + "</td>";
                                tableHtml += "<td>" + data[i].monday + "</td>";
                                tableHtml += "<td>" + data[i].tuesday + "</td>";
                                tableHtml += "<td>" + data[i].wednesday + "</td>";
                                tableHtml += "<td>" + data[i].thursday + "</td>";
                                tableHtml += "<td>" + data[i].friday + "</td>";
                                tableHtml += "<td>" + data[i].saturday + "</td>";
                                tableHtml += "<td>" + data[i].sunday + "</td>";
                                $("#" + (i + 1)).html(tableHtml)
                            }
                        })
                    })
                })
            </script>

            <h2 id="week"></h2>
            <div class="login_click" style="float: left;"><a id="del" class="btlogin"><</a></div>
            <div class="login_click" style="float: right;"><a id="add" class="btlogin">></a></div>
        </div>

        <tr>
            <th>星期 具体时间</th>
            <th id="w_1"></th>
            <th id="w_2"></th>
            <th id="w_3"></th>
            <th id="w_4"></th>
            <th id="w_5"></th>
            <th id="w_6"></th>
            <th id="w_7"></th>
        </tr>
        <%--        <tr>--%>
        <%--            <td>7:00-8:00</td>--%>
        <%--            <td colspan="5">7点起床</td>--%>
        <%--            <td colspan="2">8点起床</td>--%>
        <%--        </tr>--%>
        <script type="text/javascript">
            $(function () {
                $.get("http://localhost:8080/kcb?week="+week, function (data) {
                    for (let i = 0; i < data.length; i++) {
                        let tableHtml;
                        tableHtml += "<td >" + data[i].time + "</td>";
                        tableHtml += "<td id='w"+i+"' onclick='change(this.id,0,0)'>" + data[i].monday + "</td>";
                        tableHtml += "<td>" + data[i].tuesday + "</td>";
                        tableHtml += "<td>" + data[i].wednesday + "</td>";
                        tableHtml += "<td>" + data[i].thursday + "</td>";
                        tableHtml += "<td>" + data[i].friday + "</td>";
                        tableHtml += "<td>" + data[i].saturday + "</td>";
                        tableHtml += "<td>" + data[i].sunday + "</td>";
                        $("#" + (i + 1)).html(tableHtml)
                    }
                })
            })

            function change(id, num, week) {
                alert("<input type='button'/>")
                console.log(id)
                var byId = document.getElementById(id);
                byId.innerText = "上课"
                $.get("http://localhost:8080", function (data) {

                }, "json")
            }
        </script>
        <tr id="1"></tr>
        <tr id="2"></tr>
        <tr>
            <td>12:00-13:00</td>
            <td colspan="5">午休</td>
            <td colspan="2">午休</td>
        </tr>
        <tr id="3"></tr>
        <tr id="4"></tr>
        <tr>
            <td>17:00-17:50</td>
            <td colspan="5">晚休</td>
            <td colspan="2">晚休</td>
        </tr>
        <tr id="5"></tr>
        <tr id="6"></tr>
    </table>
</div>
</body>
</html>
