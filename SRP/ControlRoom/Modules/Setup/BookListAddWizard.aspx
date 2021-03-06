﻿<%@ Page Language="C#" MasterPageFile="~/ControlRoom/AJAX.Master"
    AutoEventWireup="true" CodeBehind="BookListAddWizard.aspx.cs" Inherits="GRA.SRP.ControlRoom.Modules.Setup.BookListAddWizard" %>

<%@ Import Namespace="GRA.SRP.DAL" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<%@ Register TagPrefix="uc1" TagName="FileUploadCtl" Src="~/Controls/FileUploadCtl.ascx" %>
<%@ Register Src="~/ControlRoom/Controls/OpenBadgesBadgeMaker.ascx" TagPrefix="uc1" TagName="OpenBadgesBadgeMaker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ValidationSummary ID="ValidationSummaryMain" runat="server"
        BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
        CssClass="ValidationSummary" Font-Bold="True" Font-Size="11px"
        HeaderText="There are errors, and no action was taken" Font-Names="Verdana" />

    <asp:Panel ID="pnlBookList" runat="server" BorderColor="#3399FF" BorderStyle="Solid" BorderWidth="0px" GroupingText=" Challenge Details" ScrollBars="Auto"
        CssClass="OrangePanel" Width="100%" Height="585px">
        <table width="100%" height="550px">
            <tr>
                <td nowrap><b>Control Room name: </b></td>
                <td colspan="3">
                    <asp:TextBox ID="BLAdminName" runat="server" Text='' ReadOnly="False" Width="90%" CssClass="form-control controlRoomValue" onblur="copyCrChallenge()"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="BLAdminName" Display="Dynamic" ErrorMessage="<font color=red>Admin Name is required</font>"
                        SetFocusOnError="True" Font-Bold="True"><font color=red> * Required </font></asp:RequiredFieldValidator>
                    <script>
                        function copyCrChallenge() {
                            if ($('.publicValue').val() == '') {
                                $('.publicValue').val($('.controlRoomValue').val());
                            }
                        }
                    </script>
                </td>
                <td nowrap valign="top" width="150px"><b>Public name: </b></td>
                <td colspan="3" valign="top">
                    <asp:TextBox ID="ListName" runat="server" Text='' ReadOnly="False" Width="90%" CssClass="form-control publicValue"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="ListName" Display="Dynamic" ErrorMessage="<font color='red'>Challenge Name is required</font>"
                        SetFocusOnError="True" Font-Bold="True"><font color='red'> * Required </font></asp:RequiredFieldValidator>
                </td>
            </tr>

<%--            <tr>
                <td nowrap><b>Admin Description: </b></td>
                <td colspan="7" valign="top">--%>
                    <asp:TextBox ID="AdminDescription" runat="server" CssClass="form-control" ReadOnly="False" Width="98%" Rows="3" TextMode="MultiLine" onblur="copyCrDescChallenge()" Visible="false"></asp:TextBox>
<%--                </td>
            </tr>--%>
            <tr>
                <td nowrap valign="top"><b>Patron Description: </b></td>
                <td colspan="7" style="height: 300px;">
                    <textarea id="Description" runat="server" class="gra-editor"></textarea>
                </td>
            </tr>

            <tr>
                <td colspan="8">
                    <asp:Panel ID="Panel1" runat="server" GroupingText=" Applicability Info" ScrollBars="Auto" Visible="True">
                        <table width="99%">
                            <tr>
                                <td nowrap style="padding-right: 0.5em;"><b>Program: </b></td>
                                <td style="padding-right: 0.5em;">
                                    <asp:DropDownList ID="ProgID" runat="server" DataSourceID="odsProg" DataTextField="AdminName" DataValueField="PID"
                                        AppendDataBoundItems="True" CssClass="form-control">
                                        <asp:ListItem Value="0" Text="All programs"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td nowrap style="padding-right: 0.5em;"><b>Branch/Library: </b></td>
                                <td style="padding-right: 0.5em;">
                                    <asp:DropDownList ID="LibraryID" runat="server" DataSourceID="odsDDBranch" DataTextField="Code" DataValueField="CID"
                                        AppendDataBoundItems="True" CssClass="form-control">
                                        <asp:ListItem Value="0" Text="[Select a Value]"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td nowrap style="padding-right: 0.5em;"><b>Literacy Level 1: </b></td>
                                <td style="padding-right: 0.5em;">
                                    <asp:TextBox ID="LiteracyLevel1" runat="server" Text=''
                                        ReadOnly="False" CssClass="align-right form-control"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revLiteracyLevel1"
                                        ControlToValidate="LiteracyLevel1"
                                        ValidationExpression="\d+"
                                        Display="Dynamic"
                                        EnableClientScript="true"
                                        ErrorMessage="<font color='red'>Literacy Level 1 must be numeric.</font>"
                                        runat="server"
                                        Font-Bold="True" Font-Italic="True"
                                        Text="<font color='red'> * Literacy Level 1 must be numeric. </font>"
                                        EnableTheming="True"
                                        SetFocusOnError="True" />
                                    <asp:RangeValidator ID="rvLiteracyLevel1"
                                        ControlToValidate="LiteracyLevel1"
                                        MinimumValue="0"
                                        MaximumValue="99"
                                        Display="Dynamic"
                                        Type="Integer"
                                        EnableClientScript="true"
                                        ErrorMessage="<font color='red'>Literacy Level 1 must be from 0 to 99!</font>"
                                        runat="server"
                                        Font-Bold="True" Font-Italic="True"
                                        Text="<font color='red'> * Literacy Level 1 must be from 0 to 99! </font>"
                                        EnableTheming="True"
                                        SetFocusOnError="True" />
                                </td>
                                <td nowrap style="padding-right: 0.5em;"><b>Literacy Level 2: </b></td>
                                <td>
                                    <asp:TextBox ID="LiteracyLevel2" runat="server" Text=''
                                        ReadOnly="False" CssClass="align-right form-control"></asp:TextBox>

                                    <asp:RegularExpressionValidator ID="revLiteracyLevel2"
                                        ControlToValidate="LiteracyLevel2"
                                        ValidationExpression="\d+"
                                        Display="Dynamic"
                                        EnableClientScript="true"
                                        ErrorMessage="<font color='red'>Literacy Level 2 must be numeric.</font>"
                                        runat="server"
                                        Font-Bold="True" Font-Italic="True"
                                        Text="<font color='red'> * Literacy Level 2 must be numeric. </font>"
                                        EnableTheming="True"
                                        SetFocusOnError="True" />
                                    <asp:RangeValidator ID="rvLiteracyLevel2"
                                        ControlToValidate="LiteracyLevel2"
                                        MinimumValue="0"
                                        MaximumValue="99"
                                        Display="Dynamic"
                                        Type="Integer"
                                        EnableClientScript="true"
                                        ErrorMessage="<font color='red'>Literacy Level 2 must be from 0 to 99!</font>"
                                        runat="server"
                                        Font-Bold="True" Font-Italic="True"
                                        Text="<font color='red'> * Literacy Level 2 must be from 0 to 99! </font>"
                                        EnableTheming="True"
                                        SetFocusOnError="True" />
                                </td>
                            </tr>

                        </table>

                    </asp:Panel>
                </td>

            </tr>




            <tr>
                <td colspan="6" height="100%" valign="bottom">
                    <asp:ImageButton ID="btnBack" runat="server"
                        CausesValidation="false"
                        ImageUrl="~/ControlRoom/Images/back.png"
                        Height="25"
                        Text="Back/Cancel" ToolTip="Back/Cancel"
                        AlternateText="Back/Cancel" OnClick="btnBack_Click" />
                    &nbsp;&nbsp;

                &nbsp;&nbsp;
                &nbsp;&nbsp;
                &nbsp;&nbsp;

                &nbsp;

                <asp:ImageButton ID="btnContinue" runat="server"
                    CausesValidation="True"
                    ImageUrl="~/ControlRoom/Images/Next_sm.png"
                    Height="25"
                    Text="Continue" ToolTip="Continue"
                    AlternateText="Continue" OnClick="btnContinue_Click" />
                </td>
            </tr>

        </table>

    </asp:Panel>

    <asp:Panel ID="pnlReward" runat="server" Visible="False" BorderColor="#3399FF" BorderStyle="Solid" BorderWidth="0px" GroupingText=" Challenge Completion " ScrollBars="Auto"
        CssClass="OrangePanel" Width="100%" Height="585px">
        <table width="100%" height="550px">
            <tr>
                <td nowrap><b>Tasks to complete: </b></td>
                <td>
                    <asp:TextBox ID="NumBooksToComplete" runat="server" Text=''
                        ReadOnly="False" Width="50px" CssClass="align-right form-control"></asp:TextBox>

                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        ControlToValidate="NumBooksToComplete"
                        ValidationExpression="\d+"
                        Display="Dynamic"
                        EnableClientScript="true"
                        ErrorMessage="<font color='red'>Num Books Required must be numeric.</font>"
                        runat="server"
                        Font-Bold="True" Font-Italic="True"
                        Text="<font color='red'> * Num Books Required must be numeric. </font>"
                        EnableTheming="True"
                        SetFocusOnError="True" />
                    <asp:RangeValidator ID="RangeValidator1"
                        ControlToValidate="NumBooksToComplete"
                        MinimumValue="0"
                        MaximumValue="9999"
                        Display="Dynamic"
                        Type="Integer"
                        EnableClientScript="true"
                        ErrorMessage="<font color='red'Num Books Required must be from 0 to 9999!</font>"
                        runat="server"
                        Font-Bold="True" Font-Italic="True"
                        Text="<font color='red'> * Num Books Required must be from 0 to 9999! </font>"
                        EnableTheming="True"
                        SetFocusOnError="True" />
                </td>
                <td colspan="4">
                    <asp:Label ID="lblDups" runat="server" Text=""></asp:Label>
                    This is the number of tasks the patron must complete in order to finish this challenge. Empty means all tasks must be completed.</td>
            </tr>
            <tr>
                <td nowrap><b>Number Points: </b></td>
                <td valign="top">
                    <asp:TextBox ID="AwardPoints" runat="server"
                        ReadOnly="False" Width="50px" CssClass="align-right form-control"></asp:TextBox>
                </td>
                <td colspan="4">
                    <asp:RegularExpressionValidator ID="revNumberPoints"
                        ControlToValidate="AwardPoints"
                        ValidationExpression="\d+"
                        Display="Dynamic"
                        EnableClientScript="true"
                        ErrorMessage="<font color=red>Number Points must be numeric.</font>"
                        runat="server"
                        Font-Bold="True" Font-Italic="True"
                        Text="<font color=red> * Number Points must be numeric. </font>"
                        EnableTheming="True"
                        SetFocusOnError="True" />
                    <asp:RangeValidator ID="rvNumberPoints"
                        ControlToValidate="AwardPoints"
                        MinimumValue="0"
                        MaximumValue="9999"
                        Display="Dynamic"
                        Type="Integer"
                        EnableClientScript="true"
                        ErrorMessage="<font color=red>Number Points must be from 0 to 9999!</font>"
                        runat="server"
                        Font-Bold="True" Font-Italic="True"
                        Text="<font color=red> * Number Points must be from 0 to 9999! </font>"
                        EnableTheming="True"
                        SetFocusOnError="True" />
                    This is the points the patrons will receive when they complete the list.
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <hr />
                </td>
            </tr>
            <tr>
                <td nowrap valign="top">
                    <br />
                    <b>Badge Awarded: </b></td>
                <td valign="top" align="left" width="250px;">
                    <asp:RadioButtonList ID="rblBadge" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="rblBadge_SelectedIndexChanged" Font-Size="14px">
                        <asp:ListItem Selected="false" Value="0" Text="  &nbsp; No Badge Awarded"></asp:ListItem>
                        <asp:ListItem Selected="true" Value="1" Text="  &nbsp; Choose An Existing Badge"></asp:ListItem>
                        <asp:ListItem Selected="false" Value="2" Text="  &nbsp; Create A New Badge"></asp:ListItem>
                    </asp:RadioButtonList>
                    *Note: If you choose to create a new badge, you need to have the badge image ready for upload on the next step.
                </td>
                <td colspan="4" valign="top" width="900px">
                    <asp:Panel ID="ExistingBadgeSelection" runat="server">
                        <table style="width: 600px;" class="margin-1em-bottom">
                            <tr>
                                <td style="width: 600px;">
                                    <asp:TextBox ID="SearchText"
                                        runat="server"
                                        CssClass="form-control"
                                        placeholder="Search for a badge"></asp:TextBox>
                                </td>
                                <td rowspan="2">
                                    <asp:LinkButton runat="server"
                                        OnClick="Search"
                                        CssClass="btn btn-success margin-1em-left"
                                        ForeColor="White"
                                        ID="SearchButton">
                                <span class="glyphicon glyphicon-search"></span>
                                Filter badge list</asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="FilterBranchId"
                                        runat="server"
                                        DataSourceID="odsDDBranch"
                                        DataTextField="Code"
                                        DataValueField="CID"
                                        AppendDataBoundItems="True"
                                        CssClass="form-control">
                                        <asp:ListItem Value="0" Text="Filter by library"></asp:ListItem>
                                    </asp:DropDownList>

                                </td>
                            </tr>
                        </table>

                        <asp:DropDownList ID="BadgeID"
                            runat="server"
                            DataSourceID="odsBadge"
                            DataTextField="AdminName"
                            DataValueField="BID"
                            Width="500"
                            Visible="true"
                            AppendDataBoundItems="True"
                            CssClass="form-control">
                            <asp:ListItem Value="0" Text="[Select a Badge]"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="6">

                    <asp:Panel ID="pnlBadge" runat="server" GroupingText=" New Badge Info" ScrollBars="Auto" Visible="False">

                        <table width="100%">
                            <tr>
                                <td nowrap valign="top">
                                    <b>Control Room Name:</b>
                                </td>
                                <td width="40%">
                                    <asp:TextBox ID="AdminName" runat="server" Width="300px" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvAdminName" runat="server" Enabled="False"
                                        ControlToValidate="AdminName" Display="Dynamic" ErrorMessage="<font color='red'>Badge Control Room Name is required</font>"
                                        SetFocusOnError="True" Font-Bold="True"><font color='red'>* Required</asp:RequiredFieldValidator>
                                </td>
                                <td nowrap valign="top">
                                    <b>Public name:</b>
                                </td>
                                <td width="40%">
                                    <asp:TextBox ID="UserName" runat="server" Width="300px" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" Enabled="False"
                                        ControlToValidate="UserName" Display="Dynamic" ErrorMessage="<font color='red'>Badge Patron Name is required</font>"
                                        SetFocusOnError="True" Font-Bold="True"><font color='red'>* Required</font></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <b>Pop-up message when badge is earned:</b>
                                    <div class="gra-editor-container-tiny">
                                        <textarea id="CustomEarnedMessage" runat="server" class="gra-editor"></textarea>
                                    </div>
                                </td>
                            </tr>

                        </table>


                    </asp:Panel>


                </td>
            </tr>
            <tr>
                <td colspan="6" height="100%" valign="bottom">
                    <asp:ImageButton ID="btnCancel2" runat="server"
                        CausesValidation="false"
                        ImageUrl="~/ControlRoom/Images/back.png"
                        Height="25"
                        Text="Back/Cancel" ToolTip="Back/Cancel"
                        AlternateText="Back/Cancel" OnClick="btnCancel2_Click" />
                    &nbsp;&nbsp;
                
                <asp:ImageButton ID="btnPrevious2" runat="server"
                    CausesValidation="false"
                    ImageUrl="~/ControlRoom/Images/Previous_sm.png"
                    Height="25"
                    Text="Previous" ToolTip="Previous"
                    AlternateText="Previous" OnClick="btnPrevious2_Click" />

                    &nbsp;&nbsp;
    
                    <asp:ImageButton ID="btnContinue2" runat="server"
                        CausesValidation="True"
                        ImageUrl="~/ControlRoom/Images/Next_sm.png"
                        Height="25"
                        Text="Continue" ToolTip="Continue"
                        AlternateText="Continue" OnClick="btnContinue2_Click" />

                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:Panel ID="pnlBadgeMore" runat="server" BorderColor="#3399FF" BorderStyle="Solid" BorderWidth="0px" GroupingText=" Event Details" ScrollBars="Auto"
        CssClass="OrangePanel" Width="100%" Height="585px" Visible="false">
        <table width="100%" height="550px">
            <tr>
                <td nowrap><b>Awards Physical Prize?: </b></td>
                <td>
                    <asp:CheckBox ID="IncludesPhysicalPrizeFlag" runat="server" Checked='False'></asp:CheckBox>
                </td>
                <td nowrap><b>Awarded Physical Prize Name: </b></td>
                <td>
                    <asp:TextBox ID="PhysicalPrizeName" runat="server" Text='' Width="285px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td nowrap><b>Send Notification?: </b></td>
                <td colspan="3">
                    <asp:CheckBox ID="GenNotificationFlag" runat="server" Checked='False'></asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td nowrap><b>Notification Subject: </b></td>
                <td colspan="3">
                    <asp:TextBox ID="NotificationSubject" runat="server" Text='' Width="70%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td nowrap colspan="4" height="125px">
                    <b>Notification Message Text: </b>
                    <textarea id="NotificationBody" runat="server" class="gra-editor"></textarea>
                </td>
            </tr>

            <tr>
                <td nowrap><b>Assign Pgm. Reward Code?: </b></td>
                <td colspan="3">
                    <asp:CheckBox ID="AssignProgramPrizeCode" runat="server" Checked="false"></asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td nowrap><b>Notification Subject: </b></td>
                <td colspan="3">
                    <asp:TextBox ID="PCNotificationSubject" runat="server" Text='' Width="70%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td nowrap colspan="4" height="125px">
                    <b>Notification Message Text: </b>
                    <textarea id="PCNotificationBody" runat="server" class="gra-editor"></textarea>
                </td>
            </tr>

            <tr>
                <td colspan="6" height="100%" valign="bottom">
                    <asp:ImageButton ID="btnCancel3" runat="server"
                        CausesValidation="false"
                        ImageUrl="~/ControlRoom/Images/back.png"
                        Height="25"
                        Text="Back/Cancel" ToolTip="Back/Cancel"
                        AlternateText="Back/Cancel" OnClick="btnCancel3_Click" />
                    &nbsp;&nbsp;
                
                <asp:ImageButton ID="btnPrevious3" runat="server"
                    CausesValidation="false"
                    ImageUrl="~/ControlRoom/Images/Previous_sm.png"
                    Height="25"
                    Text="Previous" ToolTip="Previous"
                    AlternateText="Previous" OnClick="btnPrevious3_Click" />

                    &nbsp;&nbsp;
    
                    <asp:ImageButton ID="btnContinue3" runat="server"
                        CausesValidation="True"
                        ImageUrl="~/ControlRoom/Images/Next_sm.png"
                        Height="25"
                        Text="Continue" ToolTip="Continue"
                        AlternateText="Continue" OnClick="btnContinue3_Click" />

                </td>
            </tr>
        </table>





    </asp:Panel>

    <asp:Panel ID="pnlLast" runat="server" BorderColor="#3399FF" BorderStyle="Solid" BorderWidth="0px" GroupingText=" Event Details" ScrollBars="Auto"
        CssClass="OrangePanel" Width="100%" Height="585px" Visible="false">
        <table width="100%">

            <tr>
                <td nowrap width="25%" align="center">
                    <b>Badge Category</b>
                </td>
                <td nowrap width="25%" align="center">
                    <b>Age Group</b>
                </td>
                <td nowrap width="25%" align="center">
                    <b>Branch Library</b>
                </td>
                <td nowrap width="25%" align="center">
                    <b>Location</b>
                </td>
            </tr>
            <tr>
                <td nowrap width="25%" valign="top" height="250px">
                    <div style="height: 250px; width: 100%; overflow: auto; border: solid 0px red; border: solid 1px #dddddd;">
                        <asp:GridView ID="gvCat" ShowHeader="false" runat="server" DataSourceID="odsDDBadgeCat" AutoGenerateColumns="false" Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="isMember" Checked='<%# (((int)Eval("Checked")).ToString()=="1"?true:false) %>' runat="server" />
                                        <%# Eval("Name")%>
                                        <asp:Label ID="CID" runat="server" Text='<%# Eval("CID") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </td>
                <td nowrap width="25%" valign="top" height="250px">
                    <div style="height: 250px; width: 100%; overflow: auto; border: solid 0px red; border: solid 1px #dddddd;">
                        <asp:GridView ID="gvAge" ShowHeader="false" runat="server" DataSourceID="odsDDBadgeAge" AutoGenerateColumns="false" Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="isMember" Checked='<%# (((int)Eval("Checked")).ToString()=="1"?true:false) %>' runat="server" />
                                        <%# Eval("Name")%>
                                        <asp:Label ID="CID" runat="server" Text='<%# Eval("CID") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </td>

                <td nowrap width="25%" valign="top" height="250px">
                    <div style="height: 250px; width: 100%; overflow: auto; border: solid 0px red; border: solid 1px #dddddd;">
                        <asp:GridView ID="gvBranch" ShowHeader="false" runat="server" DataSourceID="odsDDBranch2" AutoGenerateColumns="false" Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="isMember" Checked='<%# (((int)Eval("Checked")).ToString()=="1"?true:false) %>' runat="server" />
                                        <%# Eval("Name")%>
                                        <asp:Label ID="CID" runat="server" Text='<%# Eval("CID") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </td>
                <td nowrap width="25%" valign="top" height="250px">
                    <div style="height: 250px; width: 100%; overflow: auto; border: solid 0px red; border: solid 1px #dddddd;">
                        <asp:GridView ID="gvLoc" ShowHeader="false" runat="server" DataSourceID="odsDDBadgeLoc" AutoGenerateColumns="false" Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="isMember" Checked='<%# (((int)Eval("Checked")).ToString()=="1"?true:false) %>' runat="server" />
                                        <%# Eval("Name")%>
                                        <asp:Label ID="CID" runat="server" Text='<%# Eval("CID") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>

            <tr>
                <td colspan="2" valign="top"><b>Badge Image:</b><br />
                    <br />
                    <uc1:OpenBadgesBadgeMaker runat="server" ID="OpenBadgesBadgeMaker"
                        FileName="0" SmallThumbnailWidth="64" />
                </td>
                <td colspan="2" valign="top">
                    <uc1:FileUploadCtl ID="FileUploadCtl" runat="server"
                        CreateMediumThumbnail="False" CreateSmallThumbnail="True" Extension="png"
                        FileName="0" Folder="~/Images/Badges/" ImgWidth="200"
                        MediumThumbnailWidth="128" SmallThumbnailWidth="64"
                        BlankImage="no_badge" BlankSmallImage="no_badge_sm" />

                </td>
            </tr>

            <tr>
                <td colspan="4" height="100%" valign="bottom">
                    <asp:ImageButton ID="btnCancel4" runat="server"
                        CausesValidation="false"
                        ImageUrl="~/ControlRoom/Images/back.png"
                        Height="25"
                        Text="Back/Cancel" ToolTip="Back/Cancel"
                        AlternateText="Back/Cancel" OnClick="btnCancel4_Click" />
                    &nbsp;&nbsp;
                
                <asp:ImageButton ID="btnPrevious4" runat="server"
                    CausesValidation="false"
                    ImageUrl="~/ControlRoom/Images/Previous_sm.png"
                    Height="25"
                    Text="Previous" ToolTip="Previous"
                    AlternateText="Previous" OnClick="btnPrevious4_Click" />

                    &nbsp;&nbsp;
    
                    <asp:ImageButton ID="btnContinue4" runat="server"
                        CausesValidation="True"
                        ImageUrl="~/ControlRoom/Images/Next_sm.png"
                        Height="25"
                        Text="Continue" ToolTip="Continue"
                        AlternateText="Continue" OnClick="btnContinue4_Click" />

                </td>
            </tr>

        </table>
    </asp:Panel>



    <asp:Label ID="lblPK" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:Label ID="lblBID" runat="server" Text="0" Visible="False"></asp:Label>
    <asp:ObjectDataSource ID="odsData" runat="server"
        SelectMethod="FetchObject"
        TypeName="GRA.SRP.DAL.Event">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblPK" Name="EID"
                PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsProg" runat="server"
        SelectMethod="GetAll"
        TypeName="GRA.SRP.DAL.Programs"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsDDBranch" runat="server"
        SelectMethod="GetAlByTypeName"
        TypeName="GRA.SRP.DAL.Codes">
        <SelectParameters>
            <asp:Parameter Name="Name" DefaultValue="Branch" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsBadge" runat="server"
        SelectMethod="GetFiltered"
        TypeName="GRA.SRP.DAL.Badge">
        <SelectParameters>
            <asp:ControlParameter
                ControlID="SearchText"
                Name="searchText"
                PropertyName="Text"
                Type="String" />
            <asp:ControlParameter
                ControlID="FilterBranchId"
                DefaultValue="0"
                Name="BranchId"
                PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsDDBranch2" runat="server"
        SelectMethod="GetBadgeBranches"
        TypeName="GRA.SRP.DAL.Badge">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblBID" Name="BID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsDDBadgeCat" runat="server"
        SelectMethod="GetBadgeCategories"
        TypeName="GRA.SRP.DAL.Badge">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblBID" Name="BID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsDDBadgeAge" runat="server"
        SelectMethod="GetBadgeAgeGroups"
        TypeName="GRA.SRP.DAL.Badge">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblBID" Name="BID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:ObjectDataSource ID="odsDDBadgeLoc" runat="server"
        SelectMethod="GetBadgeLocations"
        TypeName="GRA.SRP.DAL.Badge">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblBID" Name="BID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

