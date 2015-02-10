<%@ Page Title="Adminsitration Home" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="CreateDebtor.aspx.cs" Inherits="DebtMateV1.Administrator.AdministrationHome" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%--<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Transparency="50" InitialDelayTime="5" IsSticky="True" MinDisplayTime="10" Skin="Sunset"> </telerik:RadAjaxLoadingPanel>--%>
   <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
    <ProgressTemplate>
        <div style="background-color: Gray; filter:alpha(opacity=60); opacity:0.60; width: 100%; top: 0px; left: 0px; position: fixed; height: 100%; z-index:90000">
        </div>
          <div style="
              margin:auto;
              font-family:Trebuchet MS;
              filter: alpha(opacity=100);
              opacity: 1;
              font-size:small;
              vertical-align: middle;
              top: 45%;
              position: fixed;
              right: 45%;
              color: #275721;
              text-align: center;
              height: 100px; z-index:90001;
              padding:15px !important;
              ">
                <table style="padding:15px; margin: 15px; background-color: White; font-family: Sans-Serif; text-align: center; border: solid 1px #275721; color: #275721; width: inherit; height: inherit; padding: 15px; z-index:90002">
                <tr>
                <td style="text-align: center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../images/Loading.gif" alt="Loading" /></td>
                <td style="text-align: inherit;"><span style="font-family: Sans-Serif; font-size: medium; font-weight: bold; font">Loading...</span></td>
                </tr>
                </table>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>

    
    <telerik:RadWindowManager ID="rwmMessageBox" runat="server" EnableShadow="True"></telerik:RadWindowManager>
    <article>
        <div class="row">
            <div class="col-md-9">
                <div class="row myCoolWhiteBorder">
                    Create / Edit Debtor
                    <hr />
                    <div class="row">
                        <div class="col-md-3">
                            Search
                        </div>
                        <div class="col-md-9">
                            <asp:SqlDataSource ID="sqlDebtors" runat="server" ConnectionString="<%$ ConnectionStrings:DebtMateDataConnectionString %>" SelectCommand="SELECT Fisrtname + ' ' + LastName + ' [' + IdNumber + ']' as DisplayName, Id FROM Debtors ORDER BY [LastName]"></asp:SqlDataSource>
                            <telerik:RadSearchBox runat="server" ID="srcDebtors" Width="100%" DataSourceID="sqlDebtors" DataTextField="DisplayName" EmptyMessage="First Name, Last Name, Id Number" ShowSearchButton="false" OnSearch="srcDebtors_Search"></telerik:RadSearchBox>
                        </div>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-3">
                                    First Name
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtFirstName" Width="100%" Skin="Sunset"></telerik:RadTextBox><br />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" Display="Dynamic" ErrorMessage="Please enter a First name!" ValidationGroup="DebtorDetails" CssClass="errorMessage"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Last Name
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtLastName" Width="100%"></telerik:RadTextBox><br />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" Display="Dynamic" ErrorMessage="Please enter a Last name!" ValidationGroup="DebtorDetails" CssClass="errorMessage"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Referred Name
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtPreferredName" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Id Number
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtIdNumber" Width="100%"></telerik:RadTextBox><br />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Marital Status
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadDropDownList runat="server" ID="ddlMaritalStatus" Skin="Sunset" RenderMode="Mobile" Width="100%"></telerik:RadDropDownList>
                                </div>
                                <div class="col-md-3">
                                    Gender
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadDropDownList runat="server" ID="ddlGender" Skin="Sunset" RenderMode="Mobile" Width="100%"></telerik:RadDropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Date of Birth
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadDatePicker runat="server" ID="dpDateOfBirth" Skin="Sunset" RenderMode="Mobile"></telerik:RadDatePicker>
                                    <br />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDateOfBirth" Display="Dynamic" ErrorMessage="Please enter a Date of Birth!" ValidationGroup="DebtorDetails" CssClass="errorMessage"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-3">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Street Address
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtStreetAddress1" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtStreetAddress2" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtStreetAddress3" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Postal Code
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtStreetPostalCode" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Postal Address
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtPostalAddress1" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtPostalAddress2" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtPostalAddress3" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Postal Code
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtPostalCode" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Tel Home
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadTextBox runat="server" ID="txtTelHome" Width="100%"></telerik:RadTextBox>
                                </div>
                                <div class="col-md-3">
                                    Tel Work
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadTextBox runat="server" ID="txtTelWork" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Fax
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadTextBox runat="server" ID="txtFax" Width="100%"></telerik:RadTextBox>
                                </div>
                                <div class="col-md-3">
                                    Cellular
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadTextBox runat="server" ID="txtCell" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    Email
                                </div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="txtEmailAddress" Width="100%"></telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <telerik:RadButton runat="server" ID="btnSave" Text="Save" Skin="Sunset" Width="100%" OnClick="btnSave_Click" AutoPostBack="true" ValidationGroup="DebtorDetails"></telerik:RadButton>
                                </div>
                                <div class="col-md-4">
                                    <telerik:RadButton runat="server" ID="btnUpdate" Text="Update" Skin="Sunset" Width="100%" OnClick="btnUpdate_Click" AutoPostBack="true" ValidationGroup="DebtorDetails"></telerik:RadButton>
                                </div>
                                <div class="col-md-4">
                                    <telerik:RadButton runat="server" ID="btnClear" Text="Clear" Skin="Sunset" Width="100%" OnClick="btnClear_Click" AutoPostBack="true" ValidationGroup="DebtorDetails"></telerik:RadButton>
                                </div>
                            </div>
                            <asp:HiddenField ID="selectedDebtor" runat="server" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="srcDebtors" />
                            <asp:AsyncPostBackTrigger ControlID="btnUpdate" />
                        </Triggers>
                    </asp:UpdatePanel>

                </div>
            </div>
            <div class="col-md-3">
                <div class="myCoolWhiteBorder" style="margin-right: 5px !important;">
                    Contact Details History
                    <hr />
                </div>
            </div>
        </div>


    </article>

</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
    <link href="../Skins/Silk/Button.Silk.css" rel="stylesheet" type="text/css" />
</asp:Content>
