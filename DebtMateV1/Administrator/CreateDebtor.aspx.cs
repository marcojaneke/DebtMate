using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DebtMateV1.Administrator
{
    public partial class AdministrationHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnUpdate.Enabled = false;
                using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
                {
                    var Genders = from gen in _dc.Genders
                                  orderby gen.Description ascending
                                  where gen.isActive.Equals(true)
                                  select gen;

                    ddlGender.DataSource = Genders;
                    ddlGender.DataTextField = "Description";
                    ddlGender.DataValueField = "Id";
                    ddlGender.DataBind();


                    var MaritalStatuses = from mStatus in _dc.MaritalStatuses
                                          orderby mStatus.Description ascending
                                          where mStatus.isActive.Equals(true)
                                          select mStatus;

                    ddlMaritalStatus.DataSource = MaritalStatuses;
                    ddlMaritalStatus.DataTextField = "Description";
                    ddlMaritalStatus.DataValueField = "Id";
                    ddlMaritalStatus.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                //Save Debtor Details


                try
                {
                    var debtorExists = _dc.Debtors.FirstOrDefault(p => p.Fisrtname == txtFirstName.Text && p.LastName == txtLastName.Text);

                    var debtorExistsSurnameID = _dc.Debtors.FirstOrDefault(p => p.LastName == txtLastName.Text);


                    Debtor newDebtor = new Debtor();

                    newDebtor.Fisrtname = txtFirstName.Text;
                    newDebtor.LastName = txtLastName.Text;
                    newDebtor.PreferredName = txtPreferredName.Text;
                    newDebtor.IdNumber = txtIdNumber.Text;
                    newDebtor.MaritalStatusID = Convert.ToInt32(ddlMaritalStatus.SelectedValue);
                    newDebtor.GenderID = Convert.ToInt32(ddlGender.SelectedValue);
                    newDebtor.DateOfBirth = dpDateOfBirth.SelectedDate;

                    _dc.Debtors.InsertOnSubmit(newDebtor);
                    _dc.SubmitChanges();

                    //Save Debtor Contact Details
                    DebtorContactDetail debtorContact = new DebtorContactDetail();

                    debtorContact.DebtorID = newDebtor.Id;
                    debtorContact.StreetAddress1 = txtStreetAddress1.Text;
                    debtorContact.StreetAddress2 = txtStreetAddress2.Text;
                    debtorContact.StreetAddress3 = txtStreetAddress3.Text;
                    debtorContact.StreetAddressPostalCode = txtStreetPostalCode.Text;

                    debtorContact.PostalAddress1 = txtPostalAddress1.Text;
                    debtorContact.PostalAddress2 = txtPostalAddress2.Text;
                    debtorContact.PostalAddress3 = txtPostalAddress3.Text;
                    debtorContact.PostalAddressCode = txtPostalCode.Text;

                    debtorContact.TelCell = txtCell.Text;
                    debtorContact.TelFax = txtFax.Text;
                    debtorContact.TelHome = txtTelHome.Text;
                    debtorContact.TelWork = txtTelWork.Text;
                    debtorContact.email1 = txtEmailAddress.Text;

                    _dc.DebtorContactDetails.InsertOnSubmit(debtorContact);
                    _dc.SubmitChanges();


                    rwmMessageBox.RadAlert("Debtor Details Save Succesfully", 330, 180, "DebtorDetails", "");
                }
                catch (Exception ex)
                {
                    rwmMessageBox.RadAlert("There was an error saving the Debtor, Please contact your administrator", 330, 180, "DebtorDetails", "");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                var DebtorDetails = (from debtDetails in _dc.Debtors
                                    join debtContDetails in _dc.DebtorContactDetails on debtDetails.Id equals debtContDetails.DebtorID
                                    where debtDetails.Id.Equals(selectedDebtor.Value)
                                    select debtDetails).FirstOrDefault<Debtor>();

                
                    //Update Debtor Details
                DebtorDetails.DebtorContactDetail.email1 = txtEmailAddress.Text;

                _dc.SubmitChanges();

                rwmMessageBox.RadAlert("Debtor Details Updated Succesfully", 330, 180, "DebtorDetails", "");

            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {

        }

        protected void srcDebtors_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
        {
            using (DebtMateDataClassesDataContext _dc = new DebtMateDataClassesDataContext())
            {
                var DebtorDetails = from debtDetails in _dc.Debtors
                                    join debtContDetails in _dc.DebtorContactDetails on debtDetails.Id equals debtContDetails.DebtorID
                                    where (debtDetails.Fisrtname + " " + debtDetails.LastName + " [" + debtDetails.IdNumber + "]").Equals(e.Text)
                                    select debtDetails;
                if (DebtorDetails.Any())
                {
                    btnUpdate.Enabled = true;
                    foreach (var item in DebtorDetails)
                    {
                        selectedDebtor.Value = item.Id.ToString();

                        txtFirstName.Text = item.Fisrtname;
                        txtLastName.Text = item.LastName;
                        txtPreferredName.Text = item.PreferredName;
                        txtIdNumber.Text = item.IdNumber;
                        txtPostalAddress1.Text = item.DebtorContactDetail.PostalAddress1;
                        txtPostalAddress2.Text = item.DebtorContactDetail.PostalAddress2;
                        txtPostalAddress3.Text = item.DebtorContactDetail.PostalAddress3;
                        txtPostalCode.Text = item.DebtorContactDetail.PostalAddressCode;

                        txtStreetAddress1.Text = item.DebtorContactDetail.StreetAddress1;
                        txtStreetAddress2.Text = item.DebtorContactDetail.StreetAddress2;
                        txtStreetAddress3.Text = item.DebtorContactDetail.StreetAddress3;
                        txtStreetPostalCode.Text = item.DebtorContactDetail.StreetAddressPostalCode;

                        txtTelHome.Text = item.DebtorContactDetail.TelHome;
                        txtTelWork.Text = item.DebtorContactDetail.TelWork;
                        txtCell.Text = item.DebtorContactDetail.TelCell;
                        txtFax.Text = item.DebtorContactDetail.TelFax;
                        txtEmailAddress.Text = item.DebtorContactDetail.email1;
                        dpDateOfBirth.SelectedDate = item.DateOfBirth != null ? item.DateOfBirth.GetValueOrDefault() : DateTime.Now;
                        ddlGender.SelectedValue = item.GenderID.ToString();
                        ddlMaritalStatus.SelectedValue = item.MaritalStatusID.ToString();
                    }
                }
               
            }
        }
    }
}