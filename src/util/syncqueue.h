#ifndef SYNCQUEUE_H
#define SYNCQUEUE_H

#include <queue>
#include <mutex>
#include <condition_variable>

template <typename T>
class SyncQueue {
private:
    std::queue<T> queue;
    std::mutex mutex;
    std::condition_variable cond;

public:
    void push(T const& value) {
        std::unique_lock<std::mutex> lock(this->mutex);
        queue.push(value);
        lock.unlock();
        this->cond.notify_one();
    }

    T pop() {
        std::unique_lock<std::mutex> lock(this->mutex);
        while(queue.empty()) {
            this->cond.wait(lock);
        }
        T rc(std::move(this->queue.front()));
        this->queue.pop();
        return rc;
    }
    int32_t size() {
        std::unique_lock<std::mutex> lock(this->mutex);
        return this->queue.size();
    }
};

#endif // SYNCQUEUE_H