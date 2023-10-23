import {BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home.jsx';
import GetUser from "./pages/user/GetUser.jsx";
import {AuthUserProvider} from "./contexts/user/AuthUserContext.jsx";
import {UserContextProvider} from "./contexts/user/UserContext.jsx";

function App() {
    return (
        <Router>
            <UserContextProvider>
                <AuthUserProvider>
            <Routes>
                <Route index element={<Home />} />
                {/* 다른 라우트들을 여기에 추가 */}
                <Route path="/user/getUser" element={<GetUser />} />
            </Routes>
                </AuthUserProvider>
            </UserContextProvider>
        </Router>
    );
}

export default App;
