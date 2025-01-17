<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>FinDash - Responsive Bootstrap 4 Admin Dashboard Template</title>
<!-- Favicon -->
<link rel="shortcut icon" href="images/favicon.ico" />
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- Typography CSS -->
<link rel="stylesheet" href="css/typography.css">
<!-- Style CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="css/responsive.css">
<c:url var="UserList" value="UserList"/>
</head>
<body>
	<!-- loader Start -->
	<div id="loading">
		<div id="loading-center"></div>
	</div>
	<!-- loader END -->
	<!-- Wrapper Start -->
	<div class="wrapper">
		<!-- Sidebar  -->
		<c:import url="/admin/sidebar.jsp" />
		<!-- TOP Nav Bar -->
		<c:import url="/admin/header.jsp" />
		<!-- TOP Nav Bar END -->
		<!-- Page Content  -->
		<div id="content-page" class="content-page">
			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-12">
						<div class="iq-card">
							<div class="iq-card-header d-flex justify-content-between">
								<div class="iq-header-title">
									<h4 class="card-title">User List</h4>
								</div>
							</div>
							<div class="iq-card-body">
								<div class="table-responsive">
									<div class="row justify-content-between">
										<div class="col-sm-12 col-md-6">
											<div id="user_list_datatable_info" class="dataTables_filter">
												<form class="mr-3 position-relative">
													<div class="form-group mb-0">
														<input type="search" class="form-control"
															id="exampleInputSearch" placeholder="Search"
															aria-controls="user-list-table">
													</div>
												</form>
											</div>
										</div>
										<div class="col-sm-12 col-md-6">
											<div class="user-list-files d-flex float-right">
												<a class="iq-bg-primary" href="javascript:void();">
													Print </a> <a class="iq-bg-primary" href="javascript:void();">
													Excel </a> <a class="iq-bg-primary" href="javascript:void();">
													Pdf </a>
											</div>
										</div>
									</div>
									<table id="user-list-table"
										class="table table-striped table-bordered mt-4" role="grid"
										aria-describedby="user-list-page-info">
										<thead>
											<tr>
												<th>Avatar</th>
												<th>Full Name</th>
												<th>Contact</th>
												<th>Email</th>
												<th>Account Type</th>
												<th>Status</th>
												<th>Join Date</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${listAccount}">
												<tr>
												<c:url var="itemAvatar" value="${item.avatar}" />
													<td class="text-center"><img
														class="rounded img-fluid avatar-40"
														src="${itemAvatar}" alt="profile"></td>
													<td>${item.fullName}</td>
													<td>${item.phoneNumber}</td>
													<td>${item.email}</td>
													<td>${item.getTypeAccount()}</td>
													<td>
													<c:if test="${item.isActive==1}"><span class="badge iq-bg-success"></c:if>
													<c:if test="${item.isActive==0}"><span class="badge iq-bg-danger"></c:if>
													${item.getIsActiveDescription()}</span></td>
											
													<td>${item.getFullJoinDate()}</td>
													<td>
														<div class="flex align-items-center list-user-action">
															<a class="iq-bg-primary" data-toggle="tooltip"
																data-placement="top" title="" data-original-title="Add"
																href="#"><i class="ri-user-add-line"></i></a> <a
																class="iq-bg-primary" data-toggle="tooltip"
																data-placement="top" title="" data-original-title="Edit"
																href="#"><i class="ri-pencil-line"></i></a> <a
																class="iq-bg-primary" data-toggle="tooltip"
																data-placement="top" title=""
																data-original-title="Delete" href="#"><i
																class="ri-delete-bin-line"></i></a>
														</div>
													</td>
												</tr>

											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="row justify-content-between mt-3">
									<div id="user-list-page-info" class="col-md-6">
										<span>Showing 1 to 5 of 5 entries</span>
									</div>
									<div class="col-md-6">
										<nav aria-label="Page navigation example">
											<ul class="pagination justify-content-end mb-0">
												<li class="page-item disabled"><a class="page-link"
													href="${UserList}?offset=${offset-1}" tabindex="-1" aria-disabled="true">Previous</a></li>
												<c:forEach var="i" begin="1" end="${limitList}">
												<c:if test="${i==offset}"><li class="page-item active"></c:if>
												<c:if test="${i!=offset}"><li class="page-item"></c:if>
												<a class="page-link"
													href="${UserList}?offset=${i}">${i}</a></li>
												</c:forEach>
											
												<li class="page-item"><a class="page-link" href="${UserList}?offset=${offset+1}">Next</a>
												</li>
											</ul>
										</nav>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Wrapper END -->
	<!-- Footer -->
	<footer class="iq-footer">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-6">
					<ul class="list-inline mb-0">
						<li class="list-inline-item"><a href="privacy-policy.html">Privacy
								Policy</a></li>
						<li class="list-inline-item"><a href="terms-of-service.html">Terms
								of Use</a></li>
					</ul>
				</div>
				<div class="col-lg-6 text-right">
					Copyright 2020 <a href="#">FinDash</a> All Rights Reserved.
				</div>
			</div>
		</div>
	</footer>
	<!-- Footer END -->

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- Appear JavaScript -->
	<script src="js/jquery.appear.js"></script>
	<!-- Countdown JavaScript -->
	<script src="js/countdown.min.js"></script>
	<!-- Counterup JavaScript -->
	<script src="js/waypoints.min.js"></script>
	<script src="js/jquery.counterup.min.js"></script>
	<!-- Wow JavaScript -->
	<script src="js/wow.min.js"></script>
	<!-- Apexcharts JavaScript -->
	<script src="js/apexcharts.js"></script>
	<!-- Slick JavaScript -->
	<script src="js/slick.min.js"></script>
	<!-- Select2 JavaScript -->
	<script src="js/select2.min.js"></script>
	<!-- Owl Carousel JavaScript -->
	<script src="js/owl.carousel.min.js"></script>
	<!-- Magnific Popup JavaScript -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<!-- Smooth Scrollbar JavaScript -->
	<script src="js/smooth-scrollbar.js"></script>
	<!-- lottie JavaScript -->
	<script src="js/lottie.js"></script>
	<!-- am core JavaScript -->
	<script src="js/core.js"></script>
	<!-- am charts JavaScript -->
	<script src="js/charts.js"></script>
	<!-- am animated JavaScript -->
	<script src="js/animated.js"></script>
	<!-- am kelly JavaScript -->
	<script src="js/kelly.js"></script>
	<!-- am maps JavaScript -->
	<script src="js/maps.js"></script>
	<!-- am worldLow JavaScript -->
	<script src="js/worldLow.js"></script>
	<!-- Style Customizer -->
	<script src="js/style-customizer.js"></script>
	<!-- Chart Custom JavaScript -->
	<script src="js/chart-custom.js"></script>
	<!-- Custom JavaScript -->
	<script src="js/custom.js"></script>
</body>
</html>