<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="user_profile.aspx.cs" Inherits="Library.user_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <center>
                                    <img src="Images/generaluser.png" width="100px" />
                                    <h5>Your Profile</h5>
                                    <span>Account Status : </span>
                                    <asp:Label ID="Label1" class="badge rounded-pill text-bg-info" runat="server" Text="Your Status"></asp:Label>
                                </center>
                                <hr />
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control mb-1" ID="txtFullName" runat="server" placeholder="Full Name"></asp:TextBox>
                                            <asp:TextBox CssClass="form-control mb-1" ID="txtEmail" TextMode="Email" runat="server" placeholder="EmailID"></asp:TextBox>
                                        </div>

                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control mb-1" ID="txtPass" runat="server" TextMode="Password" Enabled="false" placeholder="Old Password"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control mb-1" ID="TextBox1" runat="server" TextMode="Password" placeholder="New Password"></asp:TextBox>
                                        </div>

                                        <div class="form-group">
                                            <asp:Button ID="Button4" CssClass="btn btn-success btn-block btn-lg mb-1" runat="server" Text="Update" />
                                        </div>
                                    </center>
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
                                    <img src="Images/books1.png" width="100px" />
                                    <h4>Issued Books</h4>
                                    <hr />
                                </center>
                            </div>
                            <div class="row">
                                <asp:GridView class="table table-striped table-bordered" ID="GridView2" runat="server"></asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
