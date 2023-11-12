import ProductCards from "./ProductCards.jsx";
import Footer from "../../components/skeleton/Footer.jsx";

function GetProductList() {

    return(
        <>
            <h1 className="container d-flex justify-content-center align-self-center mt-5 mb-5">상품 리스트</h1>
            <ProductCards/>
            <Footer/>
        </>
    )
}

export default GetProductList;