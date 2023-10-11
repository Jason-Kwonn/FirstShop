import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './components/Home';

function App() {
    return (
        <Router>
            <Routes>
                <Route index element={<Home />} />
                {/* 다른 라우트들을 여기에 추가 */}
            </Routes>
        </Router>
    );
}

export default App;
