using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Mainform : Form
    {
        Thread _th;
        public Mainform()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            _th = new Thread(new ThreadStart(ThreadAction));
            _th.Start();
        }

        private void Mainform_Load(object sender, EventArgs e)
        {
            Thread _th = new Thread(new ThreadStart(ThreadAction));

            _th.Start();

            _th.Abort();
        }


        private void ThreadAction()
        {
            int count = 1;
            while (true)
            {
                try
                {
                    richTextBox1.AppendText("현재 처리 행 : " + count.ToString() + "\n");
                }
                catch (Exception ex)
                {

                }
                count++;
                Thread.Sleep(1000);
            }
        }



        private void DelegateThreadAction()
        {
            int count = 1;
            while (true)
            {
                try
                {
                    if (this.InvokeRequired)
                    {
                        this.Invoke(new MethodInvoker(delegate
                        {
                            richTextBox1.AppendText("현재 처리 행 : " + count.ToString() + "\n");
                        }));
                    }
                    else
                    {
                        richTextBox1.AppendText("현재 처리 행 : " + count.ToString() + "\n");
                    }
                }
                catch (Exception ex)
                {

                }
                count++;
                Thread.Sleep(1000);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            _th.Abort();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            _th = new Thread(new ThreadStart(DelegateThreadAction));
            _th.Start();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            _th = new Thread(new ThreadStart(DBSelect));

            _th.Start();
        }

        private void DBSelect()
        {
            string strConn = "Data Source=10.1.55.62,1433;Initial Catalog=LIPACO_ERP;User ID=erp_test;Password=*Dlit_Erptest#7004!";

            SqlConnection mssqlconn = new SqlConnection(strConn);

            mssqlconn.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = mssqlconn;
            cmd.CommandText = "SELECT * FROM BZ990T";

            SqlDataAdapter _sd = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            _sd.Fill(ds);

            mssqlconn.Close();


            for(int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (this.InvokeRequired)
                {
                    this.Invoke(new MethodInvoker(delegate
                    {
                        richTextBox1.AppendText(ds.Tables[0].Rows[i][1].ToString() + " : " + ds.Tables[0].Rows[i][2].ToString() + "\n");
                    }));
                }
                else
                {
                    richTextBox1.AppendText(ds.Tables[0].Rows[i][1].ToString() + " : " + ds.Tables[0].Rows[i][2].ToString() + "\n");
                }
                Thread.Sleep(1000);
            }

        }


        private void button5_Click(object sender, EventArgs e)
        {
            richTextBox1.AppendText("TEST 동작\n");
        }
    }
}
