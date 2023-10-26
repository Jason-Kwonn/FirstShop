import {BrowserRouter, Routes, Route } from 'react-router-dom';
import GetUser from "./pages/user/GetUser.jsx";
import {AuthUserProvider} from "./contexts/user/AuthUserContext.jsx";
import {UserContextProvider} from "./contexts/user/UserContext.jsx";
import Home from "./pages/Home.jsx";
import {ProductContextProvider} from "./contexts/product/ProductContext.jsx";
import GetProductList from "./pages/product/GetProductList.jsx";
import GetProduct from "./pages/product/GetProduct.jsx";
import NavBar from "./components/skeleton/NavBar.jsx";

function App() {
    return (
        <BrowserRouter>
            {/* User 라우팅*/}
            <UserContextProvider>
                <AuthUserProvider>
                    <NavBar/>
            <Routes>
                <Route index element={<Home />} />
                {/* 다른 라우트들을 여기에 추가 */}
                <Route path="/user/getUser" element={<GetUser />} />
            </Routes>
                </AuthUserProvider>
            </UserContextProvider>

            {/* Product 라우팅*/}
            <ProductContextProvider>
            <Routes>
                <Route path="/product/getProductList" element={<GetProductList/>} />
            </Routes>
            </ProductContextProvider>

            <Routes>
                <Route path="/product/getProduct/:prodNo" element={<GetProduct/>} />
            </Routes>
        </BrowserRouter>
    );
}

export default App;
