using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DebtMateV1.Administrator
{
    public partial class StatusAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnUpdate.Enabled = false;
                reloadStatusList();
            }
        }

        private void reloadStatusList()
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                var status = from cStatus in _dc.CaseStatuses
                             where cStatus.isActive == true
                             select cStatus;

                statusList.DataSource = status;
                statusList.DataTextField = "Description";
                statusList.DataValueField = "Id";
                statusList.DataBind();

            }
        }

        protected void statusList_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                CaseStatuse selectedStatus = (from cStatus in _dc.CaseStatuses
                                              where cStatus.Id == Convert.ToInt32(statusList.SelectedValue)
                                              select cStatus).FirstOrDefault<CaseStatuse>();

                statusDescription.Text = selectedStatus.Description;
                btnUpdate.Enabled = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                //check if exists

                var checkExists = _dc.CaseStatuses.Where(p => p.Description == statusDescription.Text);

                if (checkExists != null)
                {
                    rwmMessageBox.RadAlert("This status already Exists", 330, 180, "Status Exists", "");
                }
                else
                {
                    
                    CaseStatuse newStatus = new CaseStatuse();
                    newStatus.Description = statusDescription.Text;
                    newStatus.isActive = true;

                    _dc.CaseStatuses.InsertOnSubmit(newStatus);
                    _dc.SubmitChanges();
                    rwmMessageBox.RadAlert("Status added", 330, 180, "Status", "");
                    statusDescription.Text = "";

                    reloadStatusList();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                CaseStatuse status = _dc.CaseStatuses.FirstOrDefault<CaseStatuse>(p => p.Id == Convert.ToInt32(statusList.SelectedValue));

                status.Description = statusDescription.Text;
                _dc.SubmitChanges();

                rwmMessageBox.RadAlert("Update successful", 330, 180, "Status", "");
                statusDescription.Text = "";
                reloadStatusList();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                CaseStatuse status = _dc.CaseStatuses.FirstOrDefault<CaseStatuse>(p => p.Id == Convert.ToInt32(statusList.SelectedValue));

                status.isActive = false;
                _dc.SubmitChanges();

                rwmMessageBox.RadAlert("Delete successful", 330, 180, "Status", "");
                statusDescription.Text = "";
                reloadStatusList();
            }
        }
    }
}