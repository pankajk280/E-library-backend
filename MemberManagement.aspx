<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MemberManagement.aspx.cs" Inherits="Library.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="row"> 
                                <center>
                                    <img src="Images/writer.png" width="100px" />
                                    <h5>Member Management</h5>

                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col-md-6">

                                    <div class="form-group">
                                        <asp:TextBox CssClass="form-control mb-1" ID="TextBox1" runat="server" placeholder="Member Id"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <div class="form-group">
                                        <asp:Button ID="Button1" CssClass="btn btn-primary " runat="server" Text="Fetch Details" OnClick="Button1_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <asp:Button ID="Button3" CssClass="btn btn-danger " runat="server" Text="Upload" OnClick="Button3_Click" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <center>
                                    <h4>Library Members List</h4>
                                    <hr />
                                </center>
                            </div>
                            <div class="row">
                                <div class="col-md-10">
                                    <asp:GridView class="table table-striped table-bordered" ID="GridView2" runat="server" AutoGenerateColumns="true"></asp:GridView>
                                </div>
                                <div class="col-md-2">
                                    <asp:Button ID="Button2" CssClass="btn btn-secondary mb-2" runat="server" Text="Download" OnClick="Button2_Click" />


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
