using Dapper;
using log4net;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DocLoader
{
    public partial class _Default : Page
    {
        private readonly ILog _log = LogManager.GetLogger(typeof(_Default));
        public static string connString = WebConfigurationManager.ConnectionStrings["DBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public void SaveData_Click(object sender, EventArgs e)
        {
            string msisdn = Request["msisdn"];
            string newName1 = "";
            string newName2 = "";
            if (Request.QueryString["msisdn"] != null)
            {
                int result = Check(msisdn);
                if (result != 0)
                {
                    lblmsg.Text = "Ваша заявка находится на рассмотрение!";
                    lblmsg.ForeColor = System.Drawing.Color.CornflowerBlue;
                    txtTin.Text = string.Empty;
                }
                else
                {
                    try
                    {
                        SqlConnection con = new SqlConnection(connString);
                        SqlCommand cmd = new SqlCommand("sp_addNewTaxId", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("msisdn", msisdn);
                        cmd.Parameters.AddWithValue("taxId", txtTin.Text);
                        cmd.Parameters.AddWithValue("passFront", imgInp1.PostedFile.FileName.Replace(imgInp1.PostedFile.FileName, msisdn + "_pass_1.jpg"));
                        cmd.Parameters.AddWithValue("passBack", imgInp2.PostedFile.FileName.Replace(imgInp2.PostedFile.FileName, msisdn + "_pass_2.jpg"));
                        cmd.Parameters.AddWithValue("status", 1);
                        con.Open();
                        int k = cmd.ExecuteNonQuery();
                        if (k != 0)
                        {
                            if (imgInp1.PostedFile != null && imgInp1.PostedFile.ContentLength > 0)
                            {
                                newName1 = msisdn + "_pass_1.jpg";
                                Upload(imgInp1.PostedFile, newName1);
                            }
                            if (imgInp2.PostedFile != null && imgInp2.PostedFile.ContentLength > 0)
                            {
                                newName2 = msisdn + "_pass_2.jpg";
                                Upload(imgInp2.PostedFile, newName2);
                            }
                            lblmsg.Text = "Ваш ИНН успешно отправлено для модерации!";
                            lblmsg.ForeColor = System.Drawing.Color.CornflowerBlue;
                        }
                        txtTin.Text = string.Empty;
                        //MoveFiles();
                        con.Close();
                    }
                    catch (Exception ex)
                    {
                        _log.Debug("Error in insert data: " + ex.Message);
                    }
                }
            }
            else
            {
                Response.Redirect("https://google.com"); // project url
            }
        }
        public int Check(string msisdn)
        {
            int result = 0;
            using (SqlConnection con = new SqlConnection(connString))
            {
                try
                {
                    con.Open();
                    result = con.Query<int>("SELECT * FROM [DataManagementSystem].[dbo].[UserTaxId] WHERE Msisdn=@msisdn", new { msisdn }).FirstOrDefault();
                    con.Close();
                }
                catch (Exception ex)
                {
                    _log.Error("Error message: " + ex.Message);
                }
            }
            return result;
        }
        public void Upload(HttpPostedFile postedFile, string newName)
        {
            postedFile.SaveAs(Server.MapPath("~/Upload/") + newName);
        }
        //private static void MoveFiles()
        //{
        //    var sourceDir = @"C:\APPS\Merchant\Web\DocLoader\Upload\";
        //    var targetDir = @"C:\APPS\Other\TestPlace\test2\Upload\";
        //    IEnumerable<FileInfo> files = Directory.GetFiles(sourceDir).Select(f => new FileInfo(f));
        //    foreach (var file in files)
        //    {
        //        File.Copy(file.FullName, Path.Combine(targetDir, file.Name));
        //    }
        //}
    }
}