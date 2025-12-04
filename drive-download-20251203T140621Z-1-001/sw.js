// FalconPro Service Worker
const CACHE_NAME = 'falconpro-v1.0.0';
const urlsToCache = [
  '/',
  '/index.html',
  '/training.html',
  '/analytics.html',
  '/profiles.html',
  '/hood-generator.html',
  '/main.js',
  '/manifest.json',
  '/resources/hero-falcon.jpg',
  '/resources/falconer-portrait.jpg',
  '/resources/falconry-equipment.jpg',
  'https://cdn.tailwindcss.com',
  'https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js',
  'https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js',
  'https://fonts.googleapis.com/css2?family=Crimson+Text:wght@400;600;700&family=Inter:wght@300;400;500;600;700&family=Cinzel:wght@400;500;600;700&display=swap'
];

// Install event
self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

// Fetch event
self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        // Return cached version or fetch from network
        return response || fetch(event.request);
      }
    )
  );
});

// Background sync for data updates
self.addEventListener('sync', function(event) {
  console.log('Background sync triggered:', event.tag);
  
  if (event.tag === 'training-data-sync') {
    event.waitUntil(syncTrainingData());
  }
});

// Push notifications for alerts
self.addEventListener('push', function(event) {
  console.log('Push notification received:', event);
  
  const options = {
    body: event.data ? event.data.text() : 'FalconPro notification',
    icon: '/resources/icon-192x192.png',
    badge: '/resources/badge-72x72.png',
    vibrate: [100, 50, 100],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: '2'
    },
    actions: [
      {
        action: 'explore',
        title: 'View Details',
        icon: '/resources/checkmark.png'
      },
      {
        action: 'close',
        title: 'Close',
        icon: '/resources/xmark.png'
      }
    ]
  };
  
  event.waitUntil(
    self.registration.showNotification('FalconPro Alert', options)
  );
});

// Notification click handler
self.addEventListener('notificationclick', function(event) {
  console.log('Notification clicked:', event);
  
  event.notification.close();
  
  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

// Sync training data when online
async function syncTrainingData() {
  try {
    console.log('Syncing training data...');
    // Implementation for syncing training data would go here
  } catch (error) {
    console.error('Sync failed:', error);
  }
}

// Periodic background sync for health checks
self.addEventListener('periodicsync', function(event) {
  if (event.tag === 'health-check') {
    event.waitUntil(checkBirdHealth());
  }
});

async function checkBirdHealth() {
  console.log('Running periodic health check...');
  // Implementation for health monitoring would go here
}