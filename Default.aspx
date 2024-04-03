<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Library._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>

        $(document).ready(function () {

            $.ajax({
                type: 'POST',
                url: "WebServices/populateGraph.asmx/getIssuedBooksFreq",
                contentType: "application/json",
                success: function (res) {
                    console.log(res);
                    var respData = res.d;
                    console.log(res.d);
                    var bookIds = respData.map(item => item.book_id);
                    var frequencies = respData.map(item => item.frequency);
                    const chart1 = $("#chart1");
                    new Chart(chart1, {
                        type: 'bar',
                        data: {
                            labels: bookIds,
                            datasets: [{
                                label: 'Frequency',
                                data: frequencies,
                                backgroundColor: 'rgba(0, 128, 0, 0.8)', 
                                borderColor: 'rgba(0, 128, 0, 1)', 
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                x: {
                                    title: {
                                        display: true,
                                        text: 'Book ID'
                                    }
                                },

                                y: {

                                    title: {
                                        display: true,
                                        text:'Frequencies'
                                    }
                                    ,
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                },
                error: function (err) {
                    if (err.responseJSON && err.responseJSON.message) {
                        alert(err.responseJSON.message);
                    } else if (err.responseText) {
                        alert(err.responseText);
                    } else {
                        alert("An error occurred");
                    }
                }

            });


            const chart2 = $("#chart2");
            $.ajax({
                type: 'POST',
                url: "WebServices/populateGraph.asmx/getBooksStocks",
                contentType: "application/json",
                success: function (res) {
                    console.log(res);
                    var respData = res.d;
                    console.log(res.d);
                    var bookIds = respData.map(item => item.book_id);
                    var frequencies = respData.map(item => item.frequency);
                    const chart2 = $("#chart2");
                    new Chart(chart2, {
                        type: 'bar',
                        data: {
                            labels: bookIds,
                            datasets: [{
                                label: 'In Stock',
                                data: frequencies,
                                backgroundColor: 'rgba(0, 31, 63, 1)',
                                borderColor: 'rgba(0, 31, 63, 1)',
                                borderWidth: 1
                                
                            }]
                        },
                        options: {
                            scales: {
                                x: {
                                    title: {
                                        display: true,
                                        text: 'Book ID'
                                    }
                                },

                                y: {

                                    title: {
                                        display: true,
                                        text: 'Frequencies'
                                    }
                                    ,
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                },
                error: function (err) {
                    if (err.responseJSON && err.responseJSON.message) {
                        alert(err.responseJSON.message);
                    } else if (err.responseText) {
                        alert(err.responseText);
                    } else {
                        alert("An error occurred");
                    }
                }

            });

        });



        

       

    </script>


    <main>
        <section class="mb-1">
            <img src="images/home-bg.jpg" class="img-fluid w-100">
        </section>

        <section>
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">  
                                    <h5>Frequency of Issued Books</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="chart1"></canvas>
                            </div>
                        </div>

                        </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <div class="title">
                                    <h5>Available Books</h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <canvas id="chart2"></canvas>
                            </div>

                        </div>
                    </div>


                </div>
            </div>
        </section>
        <hr />
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <center>
                            <h2>Our Features</h2>
                            <b>
                                <p>Our 3 Primary Features</p>
                            </b>
                        </center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <center>
                            <img src="Images/digital-inventory.png" width="150px" />
                            <h4>Digital Book Inventory</h4>
                            <p>
                                Lorem Ipsum is simply dummy text of the printing
                                <br />
                                and typesetting industry.
                                    Lorem Ipsum has been the
                                <br />
                                industry's standard dummy text ever since the 1500s
                            </p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img src="Images/search-online.png" width="150px" />
                            <h4>Search Books</h4>
                            <p>
                                Lorem Ipsum is simply dummy text of the printing
                                <br />
                                and typesetting industry.
            Lorem Ipsum has been the
                                <br />
                                industry's standard dummy text ever since the 1500s
                            </p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img src="Images/defaulters-list.png" width="150px" />
                            <h4>Defaulters List</h4>
                            <p>
                                Lorem Ipsum is simply dummy text of the printing
                                <br />
                                and typesetting industry.
            Lorem Ipsum has been the
                                <br />
                                industry's standard dummy text ever since the 1500s
                            </p>
                        </center>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <img src="Images/in-homepage-banner.jpg" class="img-fluid" />
        </section>
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <center>
                            <h2>Our Process</h2>
                            <b>
                                <p>We have a Simple 3 Step Process</p>
                            </b>
                        </center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <center>
                            <img src="Images/sign-up.png" width="150px" />
                            <h4>Sign Up</h4>
                            <p>
                                Lorem Ipsum is simply dummy text of the printing
                        <br />
                                and typesetting industry.
                            Lorem Ipsum has been the
                        <br />
                                industry's standard dummy text ever since the 1500s
                            </p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img src="Images/search-online.png" width="150px" />
                            <h4>Search Books</h4>
                            <p>
                                Lorem Ipsum is simply dummy text of the printing
                        <br />
                                and typesetting industry.
    Lorem Ipsum has been the
                        <br />
                                industry's standard dummy text ever since the 1500s
                            </p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img src="Images/library.png" width="150px" />
                            <h4>Visit Us</h4>
                            <p>
                                Lorem Ipsum is simply dummy text of the printing
                        <br />
                                and typesetting industry.
    Lorem Ipsum has been the
                        <br />
                                industry's standard dummy text ever since the 1500s
                            </p>
                        </center>
                    </div>
                </div>
            </div>
        </section>
    </main>

</asp:Content>
