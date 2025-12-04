// Falconry Management System - Main JavaScript

// Sample bird data with comprehensive information
const birdDatabase = [
    {
        id: 1,
        name: "Aquila",
        species: "Golden Eagle",
        age: 4,
        weight: 4200,
        targetWeight: 4200,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/www.zachwildifeart.com/247bb6e05ad06bf6ef8e64fd88811f1099654dd2.jpg",
        trainingLevel: "Expert",
        lastTrained: "2025-11-07",
        notes: "Excellent hunting partner, strong recall response"
    },
    {
        id: 2,
        name: "Horus",
        species: "Peregrine Falcon",
        age: 2,
        weight: 985,
        targetWeight: 980,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/peregrinefund.org/a7861ad420818e701f485937c9904997b2c9712e.jpg",
        trainingLevel: "Advanced",
        lastTrained: "2025-11-08",
        notes: "Fast learner, excellent at lure training"
    },
    {
        id: 3,
        name: "Freya",
        species: "Red-tailed Hawk",
        age: 3,
        weight: 1280,
        targetWeight: 1250,
        status: "attention",
        image: "https://kimi-web-img.moonshot.cn/img/img.freepik.com/480299986719b53c5d2fe63743490d75a78df030.jpg",
        trainingLevel: "Intermediate",
        lastTrained: "2025-11-06",
        notes: "Slightly overweight, reduce feeding portions"
    },
    {
        id: 4,
        name: "Odin",
        species: "Gyrfalcon",
        age: 5,
        weight: 1620,
        targetWeight: 1650,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/t3.ftcdn.net/4c15905e36b312ce927bf0c304e5a9e876d7bb5b.jpg",
        trainingLevel: "Expert",
        lastTrained: "2025-11-08",
        notes: "Perfect weight for hunting season"
    },
    {
        id: 5,
        name: "Sif",
        species: "Harris's Hawk",
        age: 2,
        weight: 870,
        targetWeight: 880,
        status: "alert",
        image: "https://kimi-web-img.moonshot.cn/img/www.mikesfalconry.com/a5c5c9f5569891d29b1cd099e85b9d78f8116b91.jpg",
        trainingLevel: "Beginner",
        lastTrained: "2025-11-05",
        notes: "Weight too low, increase food intake immediately"
    },
    {
        id: 6,
        name: "Thor",
        species: "Red-tailed Hawk",
        age: 4,
        weight: 1320,
        targetWeight: 1300,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/www.publicdomainpictures.net/ef098cc777abde8c274dc44ce83781eec9b72893.jpg",
        trainingLevel: "Advanced",
        lastTrained: "2025-11-07",
        notes: "Strong hunting instincts, excellent recall"
    },
    {
        id: 7,
        name: "Luna",
        species: "Peregrine Falcon",
        age: 1,
        weight: 920,
        targetWeight: 950,
        status: "attention",
        image: "https://kimi-web-img.moonshot.cn/img/avian-behavior.org/664406cd9b1b666a29b32519ce872f331bf9190f.jpg",
        trainingLevel: "Beginner",
        lastTrained: "2025-11-08",
        notes: "Young bird, needs consistent training schedule"
    },
    {
        id: 8,
        name: "Shadow",
        species: "Golden Eagle",
        age: 6,
        weight: 4380,
        targetWeight: 4350,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/images.stockcake.com/229189b4c88476c4c6871cd3a8369f880b5fbcf7.jpg",
        trainingLevel: "Expert",
        lastTrained: "2025-11-06",
        notes: "Experienced hunter, great with beginner falconers"
    },
    {
        id: 9,
        name: "Storm",
        species: "Gyrfalcon",
        age: 3,
        weight: 1680,
        targetWeight: 1650,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/projectupland.com/375ea022575053dc481498954d703f23ef995409.jpg",
        trainingLevel: "Advanced",
        lastTrained: "2025-11-07",
        notes: "Excellent in cold weather conditions"
    },
    {
        id: 10,
        name: "Blaze",
        species: "Harris's Hawk",
        age: 3,
        weight: 910,
        targetWeight: 900,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/royalcanadianfalconry.com/2f5918a2c745d6371b2ec8d081b1fc88db555034.jpg",
        trainingLevel: "Intermediate",
        lastTrained: "2025-11-08",
        notes: "Social bird, works well in groups"
    },
    {
        id: 11,
        name: "Nova",
        species: "Peregrine Falcon",
        age: 4,
        weight: 995,
        targetWeight: 980,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/guardiananimal.com/5859cc8a475baba76f1e46b92c03e3c67c16a6f1.jpg",
        trainingLevel: "Advanced",
        lastTrained: "2025-11-08",
        notes: "Record-breaking speed in flight training"
    },
    {
        id: 12,
        name: "Rex",
        species: "Red-tailed Hawk",
        age: 5,
        weight: 1290,
        targetWeight: 1300,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/www.woodstockinn.com/a0163217ddb6cefb9d927bd1a18e5c43ed92fe05.jpg",
        trainingLevel: "Expert",
        lastTrained: "2025-11-07",
        notes: "Reliable hunting partner, consistent performer"
    },
    {
        id: 13,
        name: "Athena",
        species: "Golden Eagle",
        age: 7,
        weight: 4250,
        targetWeight: 4300,
        status: "attention",
        image: "https://kimi-web-img.moonshot.cn/img/www.westernsporting.com/38041eee8e4ffd62984bb0c3e0a94b78658fd256.jpg",
        trainingLevel: "Expert",
        lastTrained: "2025-11-05",
        notes: "Slightly underweight, monitor closely"
    },
    {
        id: 14,
        name: "Zeus",
        species: "Gyrfalcon",
        age: 4,
        weight: 1640,
        targetWeight: 1650,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/www.toledoblade.com/c17969f2f170509f7867d9978b0346a640ab2cc8.jpg",
        trainingLevel: "Advanced",
        lastTrained: "2025-11-08",
        notes: "Strong predator instincts, excellent for advanced training"
    },
    {
        id: 15,
        name: "Iris",
        species: "Harris's Hawk",
        age: 2,
        weight: 885,
        targetWeight: 880,
        status: "optimal",
        image: "https://kimi-web-img.moonshot.cn/img/i.etsystatic.com/027160e8feeb13e161226c26fdc30e511ec0b4a8.jpg",
        trainingLevel: "Beginner",
        lastTrained: "2025-11-06",
        notes: "Quick learner, very responsive to training"
    }
];

// Training session data
const trainingSessions = [
    { birdId: 2, date: "2025-11-08", type: "Flight Training", duration: 45, success: 95, weight: 985, notes: "Excellent recall response" },
    { birdId: 11, date: "2025-11-08", type: "Lure Training", duration: 30, success: 92, weight: 995, notes: "Perfect strikes on lure" },
    { birdId: 4, date: "2025-11-08", type: "Hunting Simulation", duration: 60, success: 88, weight: 1620, notes: "Strong hunting instincts" },
    { birdId: 14, date: "2025-11-08", type: "Flight Training", duration: 50, success: 90, weight: 1640, notes: "Good altitude maintenance" },
    { birdId: 7, date: "2025-11-08", type: "Recall Training", duration: 25, success: 85, weight: 920, notes: "Improving response time" },
    { birdId: 10, date: "2025-11-08", type: "Weathering", duration: 120, success: 95, weight: 910, notes: "Calm behavior outdoors" },
    { birdId: 1, date: "2025-11-07", type: "Hunting", duration: 90, success: 93, weight: 4200, notes: "Successful rabbit hunt" },
    { birdId: 6, date: "2025-11-07", type: "Flight Training", duration: 40, success: 89, weight: 1320, notes: "Strong flight patterns" },
    { birdId: 12, date: "2025-11-07", type: "Lure Training", duration: 35, success: 91, weight: 1290, notes: "Consistent performance" },
    { birdId: 3, date: "2025-11-06", type: "Weight Management", duration: 15, success: 80, weight: 1280, notes: "Slightly overweight" }
];

// Weight history data for charts
const weightHistory = {
    2: [
        { date: "2025-11-01", weight: 975 },
        { date: "2025-11-02", weight: 978 },
        { date: "2025-11-03", weight: 982 },
        { date: "2025-11-04", weight: 980 },
        { date: "2025-11-05", weight: 983 },
        { date: "2025-11-06", weight: 985 },
        { date: "2025-11-07", weight: 982 },
        { date: "2025-11-08", weight: 985 }
    ],
    4: [
        { date: "2025-11-01", weight: 1645 },
        { date: "2025-11-02", weight: 1648 },
        { date: "2025-11-03", weight: 1645 },
        { date: "2025-11-04", weight: 1650 },
        { date: "2025-11-05", weight: 1648 },
        { date: "2025-11-06", weight: 1650 },
        { date: "2025-11-07", weight: 1645 },
        { date: "2025-11-08", weight: 1620 }
    ]
};

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
    registerServiceWorker();
});

// PWA Service Worker Registration
function registerServiceWorker() {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js')
            .then(function(registration) {
                console.log('Service Worker registered successfully:', registration);
                
                // Check for updates
                registration.addEventListener('updatefound', function() {
                    console.log('Service Worker update found');
                });
            })
            .catch(function(error) {
                console.log('Service Worker registration failed:', error);
            });
    }
}

function initializeApp() {
    renderBirdGrid();
    renderWeightAlerts();
    renderRecentActivity();
    initializePerformanceChart();
    populateWeightBirdSelect();
    
    // Add event listeners
    document.getElementById('addBirdBtn').addEventListener('click', openAddBirdModal);
    document.getElementById('addBirdForm').addEventListener('submit', handleAddBird);
    document.getElementById('weightForm').addEventListener('submit', handleWeightLog);
    
    // Animate elements on load
    animateOnLoad();
}

function renderBirdGrid() {
    const grid = document.getElementById('birdGrid');
    grid.innerHTML = '';
    
    birdDatabase.forEach(bird => {
        const card = createBirdCard(bird);
        grid.appendChild(card);
    });
    
    // Animate cards
    anime({
        targets: '.bird-card',
        opacity: [0, 1],
        translateY: [30, 0],
        delay: anime.stagger(100),
        duration: 600,
        easing: 'easeOutQuart'
    });
}

function createBirdCard(bird) {
    const card = document.createElement('div');
    card.className = 'bird-card glass-card rounded-xl p-4 cursor-pointer';
    card.onclick = () => openBirdProfile(bird.id);
    
    const statusClass = `status-${bird.status}`;
    const statusText = {
        'optimal': 'Optimal',
        'attention': 'Needs Attention',
        'alert': 'Alert Required'
    };
    
    card.innerHTML = `
        <div class="relative mb-4">
            <img src="${bird.image}" alt="${bird.name}" class="w-full h-32 object-cover rounded-lg">
            <div class="absolute top-2 right-2">
                <div class="status-indicator ${statusClass}"></div>
            </div>
        </div>
        <h3 class="text-lg font-semibold text-white mb-1">${bird.name}</h3>
        <p class="text-gray-300 text-sm mb-2">${bird.species}</p>
        <div class="flex justify-between text-sm text-gray-200 mb-3">
            <span>Age: ${bird.age}y</span>
            <span>${bird.trainingLevel}</span>
        </div>
        <div class="flex justify-between items-center text-sm">
            <span class="text-gray-300">Weight:</span>
            <span class="text-white font-medium">${bird.weight}g</span>
        </div>
        <div class="flex justify-between items-center text-sm mt-1">
            <span class="text-gray-300">Status:</span>
            <span class="text-white font-medium">${statusText[bird.status]}</span>
        </div>
        <div class="mt-3 pt-3 border-t border-gray-600">
            <p class="text-xs text-gray-400">Last trained: ${formatDate(bird.lastTrained)}</p>
        </div>
    `;
    
    return card;
}

function renderWeightAlerts() {
    const container = document.getElementById('weightAlerts');
    container.innerHTML = '';
    
    const alerts = birdDatabase.filter(bird => bird.status !== 'optimal');
    
    if (alerts.length === 0) {
        container.innerHTML = '<p class="text-gray-400 text-sm">All birds at optimal weight</p>';
        return;
    }
    
    alerts.forEach(bird => {
        const alert = document.createElement('div');
        alert.className = 'flex items-center space-x-3 p-3 bg-white bg-opacity-10 rounded-lg';
        
        const statusColor = {
            'attention': 'text-yellow-400',
            'alert': 'text-red-400'
        };
        
        alert.innerHTML = `
            <div class="status-indicator status-${bird.status}"></div>
            <div class="flex-1">
                <p class="text-white text-sm font-medium">${bird.name}</p>
                <p class="${statusColor[bird.status]} text-xs">
                    ${bird.status === 'attention' ? 'Weight needs monitoring' : 'Immediate attention required'}
                </p>
            </div>
            <span class="text-gray-300 text-xs">${bird.weight}g</span>
        `;
        
        container.appendChild(alert);
    });
}

function renderRecentActivity() {
    const container = document.getElementById('recentActivity');
    container.innerHTML = '';
    
    const recentSessions = trainingSessions.slice(0, 5);
    
    recentSessions.forEach(session => {
        const bird = birdDatabase.find(b => b.id === session.birdId);
        const activity = document.createElement('div');
        activity.className = 'flex items-center space-x-3 p-3 bg-white bg-opacity-10 rounded-lg';
        
        activity.innerHTML = `
            <div class="w-8 h-8 bg-amber-600 rounded-full flex items-center justify-center">
                <span class="text-white text-xs font-bold">${session.type.charAt(0)}</span>
            </div>
            <div class="flex-1">
                <p class="text-white text-sm font-medium">${bird.name}</p>
                <p class="text-gray-300 text-xs">${session.type} - ${session.success}% success</p>
            </div>
            <span class="text-gray-400 text-xs">${formatDate(session.date)}</span>
        `;
        
        container.appendChild(activity);
    });
}

function initializePerformanceChart() {
    const chartContainer = document.getElementById('performanceChart');
    chartContainer.classList.add('fade-in-up');
    
    const chart = echarts.init(chartContainer);
    
    const option = {
        backgroundColor: 'transparent',
        textStyle: {
            color: '#ffffff'
        },
        tooltip: {
            trigger: 'axis',
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            borderColor: '#D4A574',
            textStyle: {
                color: '#ffffff'
            }
        },
        legend: {
            data: ['Training Success', 'Weight Consistency'],
            textStyle: {
                color: '#ffffff'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            data: ['Nov 1', 'Nov 2', 'Nov 3', 'Nov 4', 'Nov 5', 'Nov 6', 'Nov 7', 'Nov 8'],
            axisLine: {
                lineStyle: {
                    color: '#6B7280'
                }
            },
            axisLabel: {
                color: '#9CA3AF'
            }
        },
        yAxis: {
            type: 'value',
            axisLine: {
                lineStyle: {
                    color: '#6B7280'
                }
            },
            axisLabel: {
                color: '#9CA3AF'
            },
            splitLine: {
                lineStyle: {
                    color: 'rgba(255, 255, 255, 0.1)'
                }
            }
        },
        series: [
            {
                name: 'Training Success',
                type: 'line',
                smooth: true,
                data: [85, 88, 92, 89, 94, 91, 96, 93],
                lineStyle: {
                    color: '#7DD3FC'
                },
                areaStyle: {
                    color: {
                        type: 'linear',
                        x: 0,
                        y: 0,
                        x2: 0,
                        y2: 1,
                        colorStops: [{
                            offset: 0, color: 'rgba(125, 211, 252, 0.3)'
                        }, {
                            offset: 1, color: 'rgba(125, 211, 252, 0.1)'
                        }]
                    }
                }
            },
            {
                name: 'Weight Consistency',
                type: 'line',
                smooth: true,
                data: [78, 82, 85, 88, 86, 89, 92, 90],
                lineStyle: {
                    color: '#D4A574'
                },
                areaStyle: {
                    color: {
                        type: 'linear',
                        x: 0,
                        y: 0,
                        x2: 0,
                        y2: 1,
                        colorStops: [{
                            offset: 0, color: 'rgba(212, 165, 116, 0.3)'
                        }, {
                            offset: 1, color: 'rgba(212, 165, 116, 0.1)'
                        }]
                    }
                }
            }
        ]
    };
    
    chart.setOption(option);
    
    // Make chart responsive
    window.addEventListener('resize', () => {
        chart.resize();
    });
}

function populateWeightBirdSelect() {
    const select = document.getElementById('weightBirdSelect');
    select.innerHTML = '';
    
    birdDatabase.forEach(bird => {
        const option = document.createElement('option');
        option.value = bird.id;
        option.textContent = `${bird.name} (${bird.species})`;
        select.appendChild(option);
    });
}

// Modal functions
function openAddBirdModal() {
    document.getElementById('addBirdModal').classList.remove('hidden');
    anime({
        targets: '#addBirdModal .glass-card',
        scale: [0.8, 1],
        opacity: [0, 1],
        duration: 300,
        easing: 'easeOutQuart'
    });
}

function closeAddBirdModal() {
    anime({
        targets: '#addBirdModal .glass-card',
        scale: [1, 0.8],
        opacity: [1, 0],
        duration: 200,
        easing: 'easeInQuart',
        complete: () => {
            document.getElementById('addBirdModal').classList.add('hidden');
        }
    });
}

function handleAddBird(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const newBird = {
        id: birdDatabase.length + 1,
        name: document.getElementById('birdName').value,
        species: document.getElementById('birdSpecies').value,
        age: parseInt(document.getElementById('birdAge').value),
        weight: parseInt(document.getElementById('birdWeight').value),
        targetWeight: parseInt(document.getElementById('birdWeight').value),
        status: 'optimal',
        image: 'https://kimi-web-img.moonshot.cn/img/www.publicdomainpictures.net/ef098cc777abde8c274dc44ce83781eec9b72893.jpg',
        trainingLevel: 'Beginner',
        lastTrained: new Date().toISOString().split('T')[0],
        notes: 'New bird added to system'
    };
    
    birdDatabase.push(newBird);
    renderBirdGrid();
    renderWeightAlerts();
    populateWeightBirdSelect();
    closeAddBirdModal();
    
    // Reset form
    e.target.reset();
    
    // Show success message
    showNotification('Bird added successfully!', 'success');
}

function logWeight() {
    document.getElementById('weightModal').classList.remove('hidden');
    anime({
        targets: '#weightModal .glass-card',
        scale: [0.8, 1],
        opacity: [0, 1],
        duration: 300,
        easing: 'easeOutQuart'
    });
}

function closeWeightModal() {
    anime({
        targets: '#weightModal .glass-card',
        scale: [1, 0.8],
        opacity: [1, 0],
        duration: 200,
        easing: 'easeInQuart',
        complete: () => {
            document.getElementById('weightModal').classList.add('hidden');
        }
    });
}

function handleWeightLog(e) {
    e.preventDefault();
    
    const birdId = parseInt(document.getElementById('weightBirdSelect').value);
    const weight = parseInt(document.getElementById('currentWeight').value);
    const notes = document.getElementById('weightNotes').value;
    
    // Update bird weight
    const bird = birdDatabase.find(b => b.id === birdId);
    if (bird) {
        bird.weight = weight;
        
        // Update status based on weight
        const weightDiff = Math.abs(weight - bird.targetWeight);
        if (weightDiff <= 20) {
            bird.status = 'optimal';
        } else if (weightDiff <= 50) {
            bird.status = 'attention';
        } else {
            bird.status = 'alert';
        }
        
        // Add to weight history
        if (!weightHistory[birdId]) {
            weightHistory[birdId] = [];
        }
        weightHistory[birdId].push({
            date: new Date().toISOString().split('T')[0],
            weight: weight
        });
    }
    
    renderBirdGrid();
    renderWeightAlerts();
    closeWeightModal();
    
    // Reset form
    e.target.reset();
    
    // Show success message
    showNotification('Weight logged successfully!', 'success');
}

function openBirdProfile(birdId) {
    window.location.href = `profiles.html?bird=${birdId}`;
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `fixed top-20 right-4 z-50 p-4 rounded-lg text-white max-w-sm ${
        type === 'success' ? 'bg-green-600' : 
        type === 'error' ? 'bg-red-600' : 'bg-blue-600'
    }`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    anime({
        targets: notification,
        translateX: [300, 0],
        opacity: [0, 1],
        duration: 300,
        easing: 'easeOutQuart'
    });
    
    setTimeout(() => {
        anime({
            targets: notification,
            translateX: [0, 300],
            opacity: [1, 0],
            duration: 300,
            easing: 'easeInQuart',
            complete: () => {
                document.body.removeChild(notification);
            }
        });
    }, 3000);
}

function animateOnLoad() {
    // Animate hero section
    anime({
        targets: '.hero-title',
        opacity: [0, 1],
        translateY: [50, 0],
        duration: 1000,
        easing: 'easeOutQuart'
    });
    
    // Animate stats cards
    anime({
        targets: '.glass-card',
        opacity: [0, 1],
        translateY: [30, 0],
        delay: anime.stagger(100, {start: 500}),
        duration: 600,
        easing: 'easeOutQuart'
    });
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
        month: 'short', 
        day: 'numeric' 
    });
}

// Utility functions for other pages
function getBirdById(id) {
    return birdDatabase.find(bird => bird.id === id);
}

function getTrainingSessionsByBirdId(birdId) {
    return trainingSessions.filter(session => session.birdId === birdId);
}

function getWeightHistoryByBirdId(birdId) {
    return weightHistory[birdId] || [];
}

// Export functions for use in other pages
window.falconryApp = {
    birdDatabase,
    trainingSessions,
    weightHistory,
    getBirdById,
    getTrainingSessionsByBirdId,
    getWeightHistoryByBirdId,
    formatDate,
    showNotification
};