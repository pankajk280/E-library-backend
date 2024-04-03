<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookDescription.aspx.cs" Inherits="Library.BookDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    


    <section>
        <div class="container">
            <div class="row mb-2">
                <div class="col-md-2">
                    <div class="card">
                        <div class="card-body">
                            <img src="" width="80px" id="bookImg"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="card">
                        <div class="card-body">
                            <form>
                                 <input type="text" class="form-control d-inline" id="searchInput" disabled placeholder="What do you want to know about this book">
                                <button type="submit" class="btn btn-primary d-inline" onclick="btnSearch(); return false">Get Description</button>
                            </form>                            
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-2 " style="display:none"  id="content-row">
                <div class="card">
                    <div class="card-body">
                        <div class="container-fluid">
                            <div id="SearchContent">

                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
               <button type="submit" class="btn btn-success" id="btnSave" onclick="btnSave(this); return false" disabled >
                   Save
               </button>

            </div>

        </div>

    </section>

    <script>

        var urlParams = new URLSearchParams(window.location.search);
        var textToSearch = urlParams.get('title').trim();
        $(document).ready(function () {
            $("#searchInput").val(textToSearch);
            $.ajax({
                type: 'GET',
                async: false,
                cache: false,
                url: `https://www.googleapis.com/books/v1/volumes?q=${textToSearch}`,
                contentType: 'application/json',

                success: function (res) {
                    console.log(res.items[0].volumeInfo.imageLinks.thumbnail);
                    $('#bookImg').attr('src', res.items[0].volumeInfo.imageLinks.thumbnail);
                } 
            });
        });
        function btnSearch() {
            $("#btnSave").prop("disabled", false);
            $("#content-row").fadeIn("slow");
           
                $.ajax({
                    type: 'GET',
                    async: false,
                    cache: false,
                    url: `https://www.googleapis.com/books/v1/volumes?q=${textToSearch}`,
                    contentType: 'application/json',

                    success: function (res) {
                        console.log(res.items[0].volumeInfo.description);
                        
                        if (res.items.length > 0) {
                            $("#btnSave").prop("disabled", false);
                            $("#content-row").fadeIn("slow");
                        }
                        $("#SearchContent").html(res.items[0].volumeInfo.description);
                    },
                    error: function (err) {
                        alert("Sorry,There is some Error!!");
                    }
                });

           
        }
        function btnSave() {
            console.log("hi");
        }


    </script>

    

</asp:Content>

