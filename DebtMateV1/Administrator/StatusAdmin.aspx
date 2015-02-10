<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="StatusAdmin.aspx.cs" Inherits="DebtMateV1.Administrator.StatusAdmin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%--<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Transparency="50" InitialDelayTime="5" IsSticky="True" MinDisplayTime="10" Skin="Sunset"> </telerik:RadAjaxLoadingPanel>--%>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
        <ProgressTemplate>
            <div style="background-color: Gray; filter: alpha(opacity=60); opacity: 0.60; width: 100%; top: 0px; left: 0px; position: fixed; height: 100%; z-index: 90000">
            </div>
            <div style="margin: auto; font-family: Trebuchet MS; filter: alpha(opacity=100); opacity: 1; font-size: small; vertical-align: middle; top: 45%; position: fixed; right: 45%; color: #275721; text-align: center; height: 100px; z-index: 90001; padding: 15px !important;">
                <table style="padding: 15px; margin: 15px; background-color: White; font-family: Sans-Serif; text-align: center; border: solid 1px #275721; color: #275721; width: inherit; height: inherit; padding: 15px; z-index: 90002">
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
            <div class="col-md-12">
                    <div class="myCoolHeader">
                        Status
                    </div>
                <div class="myCoolWhiteBorder" style="margin-right:5px !important;">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                        <ContentTemplate>
                    <div class="row">
                        <div class="col-md-4">
                            <telerik:RadListBox runat="server" ID="statusList" Width="100%" Height="450px" OnSelectedIndexChanged="statusList_SelectedIndexChanged" AutoPostBack="true"></telerik:RadListBox>
                        </div>
                        <div class="col-md-7">
                            <div class="row">
                                <div class="col-md-3">Description</div>
                                <div class="col-md-9">
                                    <telerik:RadTextBox runat="server" ID="statusDescription" Width="100%"></telerik:RadTextBox>
                                    <br />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="statusDescription" Display="Dynamic" ErrorMessage="This is a required field!" ValidationGroup="statusDetails" CssClass="errorMessage"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-3">
                                    <telerik:RadButton runat="server" ID="btnSave" Width="100%" Text="Add" OnClick="btnSave_Click" ValidationGroup="statusDetails" Skin="Sunset" ></telerik:RadButton>
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadButton runat="server" ID="btnUpdate" Width="100%" Text="Update" OnClick="btnUpdate_Click" ValidationGroup="statusDetails" Skin="Sunset" ></telerik:RadButton>
                                </div>
                                <div class="col-md-3">
                                    <telerik:RadButton runat="server" ID="btnDelete" Width="100%" Text="Delete" OnClick="btnDelete_Click" ValidationGroup="statusDetails" Skin="Sunset" ></telerik:RadButton>
                                </div>
                            </div>
                        </div>
                       
                    </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSave" />
                            <asp:AsyncPostBackTrigger ControlID="btnUpdate" />
                            <asp:AsyncPostBackTrigger ControlID="btnDelete" />
                            <asp:AsyncPostBackTrigger ControlID="statusList" />
                        </Triggers>
                        </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </article>
</asp:Content>
