<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuthorLogin.aspx.cs" Inherits="Library.AuthorLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <section>
     <div class="container">
         <div class="row">
             <div class="col-md-6 mx-auto">
                 <div class="card">
                     <div class="card-body">
                         <div class="row">
                             <center>
                                 <img src="Images/adminuser.png" width="100px" />
                                 <h5>Admin Login</h5>
                             </center>
                             <hr />
                         </div>
                         <div class="row">
                             <div class="col">
                                 <center>
                                     <div class="form-group">
                                         <asp:TextBox CssClass="form-control mb-1" ID="TextBox1" runat="server" placeholder="Email"></asp:TextBox>
                                     </div>
                                     <div class="form-group">
                                         <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                                     </div>
                         
                                     <div class="form-group">
                                         <asp:Button ID="Button1" CssClass="btn btn-primary btn-lg btn-block m-1" runat="server" Text="Login" OnClick="btn_OnClick"/>
                                     </div>
                                     <div class="form-group">
                                         <asp:Button ID="Button4" CssClass="btn btn-info btn-block btn-lg mb-1" runat="server" Text="Sign Up" />
                                     </div>
                                 </center>
                             </div>

                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </section>

</asp:Content>
